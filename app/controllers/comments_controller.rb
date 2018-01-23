class CommentsController < ApplicationController
  def create
    @application = Application.find(params[:application_id])
    @profile = @application.profile
    @user = @profile.user
    @comment = Comment.new comment_params
    @job = @application.job
    @company = @job.company
    if current_user.present?
      @comment.profile_id = current_user.profile.id
      @comment.profile_username = current_user.profile.username
      Notification.create(recipient: @company, actor: current_user.profile, action: 'Nytt', notifiable: @comment, job_id: @job.id, application_id: @application.id)
    else
      @comment.company_id = current_company.id
      @comment.company_username = current_company.username
      Notice.create(recipient: @profile, actor: current_company, action: 'Nytt', notifiable: @comment, job_id: @job.id, application_id: @application.id)
    end
    @comment.application_id = @application.id
    @comment.job_id = @job.id
    if @comment.save

      if current_company.present?
        # Sends email to user when comment by company is created.
        NotificationMailer.new_comment_email(@user, @application).deliver_now
      end

      flash[:notice] = "Nytt svar skickat!"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = 'Fyll i alla fält korrekt!'
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def comment_params
    params.permit(:comment)
  end
end

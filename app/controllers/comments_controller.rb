class CommentsController < ApplicationController
  def create
    @application = Application.find(params[:application_id])
    @profile = @application.profile
    @user = @profile.user
    @comment = Comment.new comment_params
    @job = @application.job
    if current_user.present?
      @comment.profile_id = current_user.profile.id
      @comment.profile_username = current_user.profile.username
    else
      @comment.company_id = current_company.id
      @comment.company_username = current_company.username
    end
    @comment.application_id = @application.id
    @comment.job_id = @job.id
    if @comment.save

      if current_company.present?
        @comment.create_activity :create, owner: current_company, recipient: @profile, recipient_id: @user.id
        # Sends email to user when comment by company is created.
        NotificationMailer.new_comment_email(@user, @application, @comment).deliver_now
      else
        @comment.create_activity :create, owner: current_user.profile, recipient: @job.company
        # Sends email to company when comment by user is created.
        NotificationMailer.new_user_comment_email(@job.company, @application, @comment).deliver_now
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

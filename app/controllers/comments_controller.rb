class CommentsController < ApplicationController
  def create
    @application = Application.find(params[:application_id])
    @profile = Profile.find_by(id: @application.profile_id)
    @user = User.find_by(id: @profile.user_id)
    @comment = Comment.new comment_params
    @job = Job.find(params[:job_id])
    if current_user.present?
      @profile = Profile.find_by(user_id: current_user)
      @comment.profile_id = @profile.id
      @comment.profile_username = @profile.username
    else
      @company = current_company
      @comment.company_id = @company.id
      @comment.company_username = @company.username
    end
    @comment.application_id = @application.id
    @comment.job_id = @job.id
    if @comment.save

      if @company.present?
        # Sends email to user when first comment by company is created.
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

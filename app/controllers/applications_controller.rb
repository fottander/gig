class ApplicationsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def new
    @application = Application.new
    @job = Job.find(params[:job_id])
    @profile = Profile.find_by(user_id: current_user)
  end

  def show
    @application = Application.find(params[:id])
    @job = Job.find(params[:job_id])
    @comments = Comment.where(application_id: @application)
    @profile = Profile.find_by(user_id: current_user)
  end

  def create
    @job = Job.find(params[:job_id])
    @profile = Profile.find_by(user_id: current_user)
    @application = Application.new application_params
    @application.job_id = @job.id
    @application.profile_id = @profile.id
    @application.profile_username = @profile.username
    @application.job_title = @job.title
    if @application.save
      flash[:notice] = "New job application sent!"
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    @application = Application.find(params[:id])
    @application.status = false # false = hired
    if @application.save
      flash[:notice] = "Congratulations! Person has been hired."
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @job = Job.find(params[:job_id])
    @application = Application.find(params[:id])
    if @application.destroy
      flash[:notice] = "Application deleted!"
      redirect_back(fallback_location: dashboards_path)
    end
  end

  private

  def application_params
    params.require(:application).permit(:message)
  end
end

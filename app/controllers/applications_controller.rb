class ApplicationsController < ApplicationController
  before_action :authenticate_user!, only: [:new,:create]

  def new
    @application = Application.new
    @job = Job.find(params[:job_id])
    @profile = Profile.find_by(user_id: current_user)
  end

  def show
    @application = Application.find(params[:id])
  end

  def create
    @job = Job.find(params[:job_id])
    @profile = Profile.find_by(user_id: current_user)
    @application = Application.new application_params
    @application.job_id = @job.id
    @application.profile_id = @profile.id
    @application.profile_username = @profile.username
    if @application.save
      flash[:notice] = "New job application sent!"
      redirect_back(fallback_location: job_path(@job))
    end
  end

  private

  def application_params
    params.require(:application).permit(:message)
  end
end

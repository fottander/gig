class ApplicationsController < ApplicationController
  before_action :authenticate_user!, only: [:new,:create]
  
  def index
  end

  def new
    @application = Application.new
    @job = Job.find(params[:job_id])
  end

  def create
    @job = Job.find(params[:job_id])
    @application = Application.new application_params
    @application.job_id = @job.id
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

class JobsController < ApplicationController
  before_action :authenticate_company!, except: [:index]

  def index
    @jobs = Job.all.order(created_at: :desc)
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new job_params
    @job.company_id = current_company.id
    if @job.save
      flash[:notice] = "New job created!"
      redirect_to new_job_path
    end
  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :requirement, :category, :city, :budget, :deadline, :duration, :hour_week, :active)
  end

end

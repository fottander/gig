class JobsController < ApplicationController
  before_action :authenticate_company!, except: [:index, :show]

  def index
    @jobs = Job.all.order(created_at: :desc)
  end

  def show
    @job = Job.find(params[:id])
  end

  def edit
    @job = Job.find(params[:id])
  end

  def update
    @job = Job.find(params[:id])
    if @job.update job_params
      flash[:notice] = "Job edited!"
      redirect_back(fallback_location: job_path(@job))
    end
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

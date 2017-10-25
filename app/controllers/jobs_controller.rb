class JobsController < ApplicationController
  before_action :authenticate_company!, except: [:index, :show]

  def index
    @jobs = Job.where(nil).paginate(page: params[:page])
    filtering_params(params).each do |key, value|
      @jobs = @jobs.public_send(key, value) if value.present?
    end
  end

  def show
    @job = Job.find(params[:id])
    @applications = @job.applications
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
    @job.company_name = current_company.name
    @job.company_city = current_company.city
    if @job.save
      flash[:notice] = "New job created!"
      redirect_to new_job_path
    end
  end

  def destroy
    @job = Job.find(params[:id])
    if @job.destroy
      flash[:notice] = "Job Deleted!"
      redirect_back(fallback_location: panels_path)
    end
  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :requirement, :category, :city, :budget, :deadline, :duration, :hour_week, :active)
  end

  def filtering_params(params)
    params.slice(:with_category)
  end

end

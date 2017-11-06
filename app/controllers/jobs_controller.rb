class JobsController < ApplicationController
  before_action :authenticate_company!, except: [:index, :show]

  def index
    @jobs = Job.where(nil).paginate(page: params[:page]).expired
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
    respond_to do |format|
      if @job.update job_params
        format.html { redirect_to edit_job_path(@job), notice: 'Jobb redigerat!' }
        format.json { render :edit, status: :ok, location: @job }
      else
        format.html { render :edit }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new job_params
    @job.company_id = current_company.id
    @job.company_username = current_company.username
    @job.company_city = current_company.city
    respond_to do |format|
      if @job.save
        format.html { redirect_to new_job_path, notice: 'Ny annons skapad!' }
        format.json { render :new, status: :created}
      else
        format.html { render :new }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @job = Job.find(params[:id])
    if @job.destroy
      flash[:notice] = "Jobb raderat!"
      redirect_back(fallback_location: panels_path)
    end
  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :active, :requirement, :category, :city, :budget, :deadline, :duration, :hour_week, :active)
  end

  def filtering_params(params)
    params.slice(:with_category)
  end

end

class JobsController < ApplicationController
  before_action :authenticate_company!, except: [:index, :show]

  def index
    add_breadcrumb 'Start', :root_path
    add_breadcrumb 'Hitta Jobb'
    sleep 1
    @jobs = Job.where(nil).paginate(page: params[:page]).active.expired
    filtering_params(params).each do |key, value|
      @jobs = @jobs.public_send(key, value) if value.present?
    end
  end

  def show
    sleep 1
    @job = Job.find(params[:id])
    @applications = @job.applications.paginate(page: params[:page])
    add_breadcrumb 'Start', :root_path
    add_breadcrumb 'Hitta Jobb', :jobs_path
    add_breadcrumb @job.title
  end

  def edit
    @job = Job.find(params[:id])
  end

  def update
    @job = Job.find(params[:id])
    respond_to do |format|
      if @job.update job_params
        format.html { redirect_to job_path(@job), notice: 'Jobb redigerat!' }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
    add_breadcrumb 'Start', :root_path
    add_breadcrumb 'Skapa Annons'
    @job = Job.new
  end

  def create
    @job = Job.new job_params
    @job.company_id = current_company.id
    @job.company_username = current_company.username
    @job.company_city = current_company.city
    respond_to do |format|
      if @job.save
        format.html { redirect_to job_path(@job), notice: "Ny annons skapad! Vi skickar ett email när du får svar på annonsen. Status för annonsen hittar du i kontrollpanelen ⤴" }
        format.json { render :show, status: :created}
      else
        format.html { render :new }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :jobtype, :active, :requirement, :category_ids, :city_ids, :budget, :deadline, :duration, :hour_day, :when_in_time, :active, :avatar)
  end

  def filtering_params(params)
    params.slice(:with_category, :with_city)
  end

end

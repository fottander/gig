class JobsController < ApplicationController
  before_action :authenticate_company!, except: [:index, :show]

  def index
    add_breadcrumb 'Start', :root_path
    add_breadcrumb 'Hitta Jobb'
    @jobs = Job.where(nil).paginate(page: params[:page]).active.expired
    filtering_params(params).each do |key, value|
      @jobs = @jobs.public_send(key, value) if value.present?
    end
  end

  def show
    @job = Job.find(params[:id])
    @applications = @job.applications
    @invoices = Invoice.where(company_id: @job.company_id)
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
        format.html { redirect_to edit_job_path(@job), notice: 'Jobb redigerat!' }
        format.json { render :edit, status: :ok, location: @job }
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
    params.require(:job).permit(:title, :description, :active, :requirement, :category_ids, :city_ids, :budget, :deadline, :duration, :hour_week, :active, :avatar)
  end

  def filtering_params(params)
    params.slice(:with_category, :with_city)
  end

end

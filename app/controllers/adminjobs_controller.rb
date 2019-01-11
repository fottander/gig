class AdminjobsController < ApplicationController
  before_action :authenticate_admin!
  def index
    sleep 1
    @jobs = Job.where(nil).paginate(page: params[:page])
    filtering_params(params).each do |key, value|
      @jobs = @jobs.public_send(key, value) if value.present?
    end
  end

  def create
    @job = Job.new job_params
    @job.company = Company.find_by(id: params[:company_id])
    @job.real = false
    respond_to do |format|
      if @job.save
        format.html { redirect_to job_path(@job), notice: "Ny annons skapad!" }
        format.json { render :show, status: :created}
      else
        format.html { render :new }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @job = Job.find(params[:id])
    @applications = Application.where(job_id: @job.id)
  end

  def destroy
    @job = Job.find(params[:id])
    if @job.destroy
      flash[:notice] = "Jobb raderat"
      redirect_back(fallback_location: administrations_path)
    else
      flash[:alert] = 'Något gick fel. Försök igen eller kontakta kundtjänst.'
      redirect_back(fallback_location: administrations_path)
    end
  end

  def edit
    @job = Job.find(params[:id])
  end

  def update
    @job = Job.find(params[:id])
    respond_to do |format|
      if @job.update job_update_params
        format.html { redirect_to edit_adminjob_path(@job), notice: 'Annons ändrad' }
        format.json { render :edit, status: :ok, location: @job }
      else
        format.html { render :edit }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def filtering_params(params)
    params.slice(:with_id, :with_company_username, :with_company_id)
  end

  def job_update_params
    params.require(:job).permit(:title, :description, :jobtype, :active, :requirement, :category_ids, :city_ids, :budget, :deadline, :duration, :hour_day, :when_in_time, :active, :avatar)
  end

  def job_params
    params.permit(:title, :description, :jobtype, :active, :requirement, :category_ids, :city_ids, :company, :budget, :deadline, :duration, :hour_day, :when_in_time, :active, :avatar, :company_username, :company_city, :company_id)
  end

end

class AdminjobsController < ApplicationController
  before_action :authenticate_admin!
  def index
    sleep 1
    @jobs = Job.where(nil).paginate(page: params[:page])
    filtering_params(params).each do |key, value|
      @jobs = @jobs.public_send(key, value) if value.present?
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
    end
  end

  private

  def filtering_params(params)
    params.slice(:with_id, :with_company_username, :with_company_id)
  end
end

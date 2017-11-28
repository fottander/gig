class Api::V1::ApplicationsController < ApiController

  def index
    @job = Job.find(params[:job_id])
    @applications = Application.where(job_id: @job.id)
  end

  def show
    begin
      @application = Application.find(params[:id])
    rescue => error
      render json: { message: error}, status: 404
    end
  end
end

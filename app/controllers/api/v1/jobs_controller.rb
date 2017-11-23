class Api::V1::JobsController < ApiController
  def index
    @jobs = Job.all
  end

  def show
    begin
      @job = Job.find(params[:id])
    rescue => error
      render json: { message: error}, status: 404
    end
  end
end

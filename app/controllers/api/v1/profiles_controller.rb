class Api::V1::ProfilesController < ApiController
  def index
    @profiles = Profile.all
  end

  def show
    begin
      @profile = Profile.find(params[:id])
    rescue => error
      render json: { message: error}, status: 404
    end
  end
end

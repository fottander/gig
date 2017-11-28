class Api::V1::UsersController < ApiController
  def index
    @users = User.all
  end

  def show
    begin
      @user = User.find(params[:id])
    rescue => error
      render json: { message: error}, status: 404
    end
  end
end

class UsersController < ApplicationController
  before_action :authenticate_admin!
  def index
    sleep 1
    @users = User.where(nil).paginate(page: params[:page])
    filtering_params(params).each do |key, value|
      @users = @users.public_send(key, value) if value.present?
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = "Användare raderad"
      redirect_back(fallback_location: administrations_path)
    end
  end

  private

  def filtering_params(params)
    params.slice(:with_email, :with_id)
  end
end

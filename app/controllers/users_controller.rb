class UsersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @users = User.where(nil).paginate(page: params[:page])
    filtering_params(params).each do |key, value|
      @users = @users.public_send(key, value) if value.present?
    end
  end

  private

  def filtering_params(params)
    params.slice(:with_email)
  end
end

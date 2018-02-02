class AdminprofilesController < ApplicationController
  before_action :authenticate_admin!
  def index
    sleep 1
    @profiles = Profile.where(nil).paginate(page: params[:page])
    filtering_params(params).each do |key, value|
      @profiles = @profiles.public_send(key, value) if value.present?
    end
  end

  private

  def filtering_params(params)
    params.slice(:with_username, :with_id)
  end
end

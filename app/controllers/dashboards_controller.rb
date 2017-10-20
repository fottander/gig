class DashboardsController < ApplicationController
  before_action :authenticate_user!
  def index
    @profile = Profile.find_by(user_id: current_user)
    @applications = Application.where(profile_id: current_user.profile)
  end
end

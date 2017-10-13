class ProfilesController < ApplicationController

  def new
    @profile = Profile.new
  end

  def show
    @profile = Profile.find_by(user_id: current_user)
  end

  def create
    @profile = Profile.new profile_params
    @profile.user_id = current_user.id
    if @profile.save
      flash[:notice] = "New profile created!"
      @profile = Profile.find_by(user_id: current_user)
      session[:current_profile_id] = @profile.id
      redirect_to dashboards_path
    end
  end

  def edit

  end

  private

  def profile_params
    params.require(:profile).permit(:username, :title, :description, :skill, :rate, :category, :city)
  end
end

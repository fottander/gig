class ProfilesController < ApplicationController

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new profile_params
    @profile.user_id = current_user.id
    if @profile.save
      flash[:notice] = "New profile created!"
      redirect_to new_profile_path
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:username, :title, :description, :skill, :rate, :category, :city)
  end
end

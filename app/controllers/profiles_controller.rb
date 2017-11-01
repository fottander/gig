class ProfilesController < ApplicationController

  def index
    @profiles = Profile.where(nil).paginate(page: params[:page])
    filtering_params(params).each do |key, value|
      @profiles = @profiles.public_send(key, value) if value.present?
    end
  end

  def new
    @profile = Profile.new
  end

  def show
    @profile = Profile.find(params[:id])
  end

  def create
    @profile = Profile.new profile_params
    @profile.user_id = current_user.id
    if @profile.save
      flash[:notice] = "Ny profil skapad!"
      @profile = Profile.find_by(user_id: current_user)
      session[:current_profile_id] = @profile.id
      redirect_to dashboards_path
    end
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])
    if @profile.update profile_params
      flash[:notice] = "Profil redigerad!"
      redirect_back(fallback_location: profile_path(@profile))
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:username, :title, :description, :skill, :rate, :category, :city)
  end

  def filtering_params(params)
    params.slice(:with_category)
  end

end

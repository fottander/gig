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
    respond_to do |format|
      if @profile.save
        format.html { redirect_to dashboards_path, notice: 'Ny profil skapad!' }
        format.json { render :new, status: :created}
        @profile = Profile.find_by(user_id: current_user)
        session[:current_profile_id] = @profile.id
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])
    respond_to do |format|
      if @profile.update profile_params
        format.html { redirect_to edit_profile_path(@profile), notice: 'Profil redigerad!' }
        format.json { render :edit, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
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

class AdminprofilesController < ApplicationController
  before_action :authenticate_admin!
  def index
    sleep 1
    @profiles = Profile.where(nil).paginate(page: params[:page])
    filtering_params(params).each do |key, value|
      @profiles = @profiles.public_send(key, value) if value.present?
    end
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])
    respond_to do |format|
      if @profile.update profile_params
        format.html { redirect_to edit_adminprofile_path(@profile), notice: 'Profil redigerad!' }
        format.json { render :edit, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @profile = Profile.find(params[:id])
    if @profile.destroy
      flash[:notice] = "Frilansare raderad"
      redirect_back(fallback_location: administrations_path)
    else
      flash[:alert] = 'Något gick fel. Försök igen eller kontakta kundtjänst.'
      redirect_back(fallback_location: administrations_path)
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:username, :title, :age, {category_ids:[]}, :avatar, :description, :skill, :category, :city_ids, :language, :license, :education, :prev_work)
  end

  def filtering_params(params)
    params.slice(:with_username, :with_id)
  end
end

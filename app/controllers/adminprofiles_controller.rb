class AdminprofilesController < ApplicationController
  before_action :authenticate_admin!
  def index
    sleep 1
    @profiles = Profile.where(nil).paginate(page: params[:page])
    filtering_params(params).each do |key, value|
      @profiles = @profiles.public_send(key, value) if value.present?
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

  def filtering_params(params)
    params.slice(:with_username, :with_id)
  end
end

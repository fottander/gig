class CompaniesController < ApplicationController
  before_action :authenticate_admin!
  def index
    sleep 1
    @companies = Company.where(nil).paginate(page: params[:page])
    filtering_params(params).each do |key, value|
      @companies = @companies.public_send(key, value) if value.present?
    end
  end

  def destroy
    @company = Company.find(params[:id])
    if @company.destroy
      flash[:notice] = "Företag raderat"
      redirect_back(fallback_location: administrations_path)
    else
      flash[:alert] = 'Något gick fel. Försök igen eller kontakta kundtjänst.'
      redirect_back(fallback_location: administrations_path)
    end
  end

  private

  def filtering_params(params)
    params.slice(:with_email, :with_name, :with_id)
  end
end

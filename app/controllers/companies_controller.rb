class CompaniesController < ApplicationController
  before_action :authenticate_admin!
  def index
    @companies = Company.where(nil).paginate(page: params[:page])
    filtering_params(params).each do |key, value|
      @companies = @companies.public_send(key, value) if value.present?
    end
  end

  private

  def filtering_params(params)
    params.slice(:with_email, :with_name)
  end
end

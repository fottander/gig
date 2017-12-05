class AdmininvoicesController < ApplicationController
  before_action :authenticate_admin!, only: [:index, :show]

  def index
    @invoices = Invoice.where(nil).paginate(page: params[:page])
    filtering_params(params).each do |key, value|
      @invoices = @invoices.public_send(key, value) if value.present?
    end
  end

  def show
    @invoice = Invoice.find(params[:id])
    @companies = Company.where(id: @invoice.company_id)
    @profiles = Profile.where(id: @invoice.profile_id)
  end

  private

  def filtering_params(params)
    params.slice(:with_id, :with_user_id, :with_company_id)
  end

end

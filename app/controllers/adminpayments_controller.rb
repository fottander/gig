class AdminpaymentsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @invoices = Invoice.where(nil).paginate(page: params[:page])
    filtering_params(params).each do |key, value|
      @invoices = @invoices.public_send(key, value) if value.present?
    end
  end

  private

  def filtering_params(params)
    params.slice(:pay_day)
  end
end

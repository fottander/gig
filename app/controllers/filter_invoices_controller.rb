class FilterInvoicesController < ApplicationController
  before_action :authenticate_admin!

  def index
    sleep 1
    @invoices = Invoice.where(nil).paginate(page: params[:page])
    filtering_params(params).each do |key, value|
      @invoices = @invoices.public_send(key, value) if value.present?
    end
  end

  def new
    sleep 1
    @invoices = Invoice.where(nil).paginate(page: params[:page])
    filtering_params(params).each do |key, value|
      @invoices = @invoices.public_send(key, value) if value.present?
    end
  end

  private

  def filtering_params(params)
    params.slice(:with_ocr, :with_job_id, :with_profile_id, :pay_day, :pay_day_reached)
  end
end

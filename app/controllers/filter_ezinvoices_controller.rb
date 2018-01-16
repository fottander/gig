class FilterEzinvoicesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @ezinvoices = Ezinvoice.where(nil).paginate(page: params[:page])
    filtering_params(params).each do |key, value|
      @ezinvoices = @ezinvoices.public_send(key, value) if value.present?
    end
  end

  def new
    @ezinvoices = Ezinvoice.where(nil).paginate(page: params[:page])
    filtering_params(params).each do |key, value|
      @ezinvoices = @ezinvoices.public_send(key, value) if value.present?
    end
  end

  private

  def filtering_params(params)
    params.slice(:with_ocr, :with_profile_id)
  end
end

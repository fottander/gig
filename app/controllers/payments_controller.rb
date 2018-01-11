class PaymentsController < ApplicationController
  before_action :authenticate_user!
  def index
    @profile = Profile.find_by(user_id: current_user)
    @invoices = Invoice.where(profile_id: @profile.id).paginate(page: params[:page])
    @ezinvoices = Ezinvoice.where(profile_id: @profile.id).paginate(page: params[:page])
  end

  def show
    @profile = Profile.find_by(user_id: current_user)
    if @invoice.present?
      @invoice = Invoice.find(params[:id])
    else
      @ezinvoice = Ezinvoice.find(params[:id])
    end
  end
end

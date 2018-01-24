class PaymentsController < ApplicationController
  before_action :authenticate_user!
  def index
    @invoices = Invoice.where(profile_id: current_user.profile.id).paginate(page: params[:page])
    @ezinvoices = Ezinvoice.where(profile_id: current_user.profile.id).paginate(page: params[:page])
  end

  def show
    @invoice = Invoice.find(params[:id])
  end
end

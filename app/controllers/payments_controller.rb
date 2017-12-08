class PaymentsController < ApplicationController
  before_action :authenticate_user!
  def index
    @profile = Profile.find_by(user_id: current_user)
    @invoices = Invoice.where(profile_id: @profile.id).paginate(page: params[:page])
  end

  def show
    @profile = Profile.find_by(user_id: current_user)
    @invoice = Invoice.find(params[:id])
  end
end

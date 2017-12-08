class PaymentsController < ApplicationController
  before_action :authenticate_user!
  def index
    @profile = Profile.find_by(user_id: current_user)
    @invoices = Invoice.where(profile_id: @profile.id).paginate(page: params[:page])
  end

  def show
    @profile = Profile.find_by(user_id: current_user)
    @invoice = Invoice.find(params[:id])
    @avgift = 0.0598
    @arbetsgivaravgift = 0.2391
    @inkomstskatt = 0.3
    @steg1 = @invoice.amount * (1-@avgift)
    @steg2 = @steg1 * (1-@arbetsgivaravgift)
    @steg3 = @steg2 * (1-@inkomstskatt)
    @varavgift = @invoice.amount * @avgift
    @socialaavgifter = @steg1 * @arbetsgivaravgift
    @bruttolon = @steg1 - @socialaavgifter
    @skatt = @bruttolon * @inkomstskatt
  end
end

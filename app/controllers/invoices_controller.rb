class InvoicesController < ApplicationController
  def create
    @profile = Profile.find_by(user_id: current_user)
    @invoice = Invoice.new invoice_params
    @invoice.profile_id = @profile.id
    @invoice.profile_username = @profile.username
    if @invoice.save
      flash[:notice] = "Faktura skapad"
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def invoice_params
    params.permit(:description, :quantity, :unit, :amount, :first_day, :last_day, :user_reference, :company_reference, :terms, :paid, :active, :application_id, :job_id, :profile_id, :profile_username)
  end
end

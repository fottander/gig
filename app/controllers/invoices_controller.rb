class InvoicesController < ApplicationController
  def create
    @profile = Profile.find_by(user_id: current_user)
    @invoice = Invoice.new invoice_params
    @invoice.profile_id = @profile.id
    @invoice.profile_username = @profile.username
    @invoice.user_id = current_user.id
    if @invoice.save
      flash[:notice] = "Faktura skapad"
      redirect_back(fallback_location: root_path)
    end
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  def edit
    @profile = Profile.find_by(user_id: current_user)
    @invoice = Invoice.find(params[:id])
  end

  def update
    @invoice = Invoice.find(params[:id])
    if @invoice.update invoice_params
      flash[:notice] = "Faktura ändrad"
      redirect_back(fallback_location: invoice_path(@invoice))
    end
  end

  def destroy
    @invoice = Invoice.find(params[:id])
    if @invoice.destroy
      flash[:notice] = "Invoice Deleted!"
      redirect_back(fallback_location: dashboards_path)
    end
  end

  private

  def invoice_params
    params.require(:invoice).permit(:description, :quantity, :unit, :amount, :first_day, :last_day, :user_reference, :company_reference, :terms, :paid, :active, :company_id, :application_id, :job_id, :profile_id, :profile_username)
  end
end

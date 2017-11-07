class InvoicesController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy, :create]
  before_action :authenticate_company!, only: [:show, :activate]
  def create
    @profile = Profile.find_by(user_id: current_user)
    @invoice = Invoice.new invoice_params
    @invoice.profile_id = @profile.id
    @invoice.profile_username = @profile.username
    @invoice.user_id = current_user.id
    if @invoice.save
      flash[:notice] = "Faktura skapad"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = 'Fyll i alla fält korrekt!'
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
    respond_to do |format|
      if @invoice.update invoice_update_params
        format.html { redirect_to invoice_path(@invoice), notice: 'Faktura ändrad' }
        format.json { render :edit, status: :ok, location: @invoice }
      else
        format.html { render :edit }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  def activate
    @invoice = Invoice.find(params[:id])
    @invoice.active = true
    if @invoice.update invoice_activate_params
      flash[:notice] = "Faktura godkänd och aktiverad"
      redirect_back(fallback_location: panels_path)
    end
  end

  def destroy
    @invoice = Invoice.find(params[:id])
    if @invoice.destroy
      flash[:notice] = "Faktura raderad!"
      redirect_back(fallback_location: dashboards_path)
    end
  end

  private

  def invoice_params
    params.permit(:description, :quantity, :unit, :amount, :first_day, :last_day, :user_reference, :company_reference, :terms, :paid, :active, :company_id, :application_id, :job_id, :profile_id, :profile_username)
  end

  def invoice_update_params
    params.require(:invoice).permit(:description, :quantity, :unit, :amount, :first_day, :last_day, :user_reference, :company_reference, :terms, :paid, :active, :company_id, :application_id, :job_id, :profile_id, :profile_username)
  end

  def invoice_activate_params
    params.permit(:active, :terms)
  end
end

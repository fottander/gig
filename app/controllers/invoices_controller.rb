class InvoicesController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy, :create]
  before_action :authenticate_company!, only: [:extend]

  def create
    @invoice = Invoice.new invoice_params
    @application = Application.find(params[:application_id])
    @company = @application.job.company
    @invoice.profile_id = current_user.profile.id
    @invoice.profile_username = current_user.profile.username
    @invoice.user_id = current_user.id
    @invoice.user_fee = current_user.fee
    @invoice.active = true
    if @invoice.save
      @application.update_attributes(complete: true)
      @invoice.create_activity :create, owner: current_user.profile, recipient: @company

      # Sends email to company when invoice is created.
      NotificationMailer.new_invoice_email(@company, @invoice).deliver_now

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
    @invoice = Invoice.find(params[:id])
  end

  def update
    @invoice = Invoice.find(params[:id])
    @company = Company.find_by(id: @invoice.company_id)
    respond_to do |format|
      if @invoice.update invoice_update_params
        @invoice.create_activity :update, owner: current_user.profile, recipient: @company
        format.html { redirect_to edit_invoice_path(@invoice), notice: 'Faktura ändrad' }
        format.json { render :edit, status: :ok, location: @invoice }
      else
        format.html { render :edit }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  def extend
    @invoice = Invoice.find(params[:id])
    @user = @invoice.user
    if @invoice.update invoice_extend_params
      if @invoice.post == true
        @invoice.update(amount: @invoice.amount + 40)
      end
      if @invoice.terms == 30
        @invoice.update(amount: @invoice.amount + 500)
      end
      flash[:notice] = "Sparat!"
      redirect_back(fallback_location: panels_path)
    else
      flash[:alert] = 'Något gick fel. Försök igen eller kontakta kundtjänst.'
      redirect_back(fallback_location: panels_path)
    end
  end

  def destroy
    @invoice = Invoice.find(params[:id])
    if @invoice.destroy
      flash[:notice] = "Faktura raderad!"
      redirect_back(fallback_location: dashboards_path)
    else
      flash[:alert] = 'Något gick fel. Försök igen eller kontakta kundtjänst.'
      redirect_back(fallback_location: dashboards_path)
    end
  end

  private

  def invoice_params
    params.permit(:description, :quantity, :unit, :amount, :first_day, :last_day, :user_reference, :company_reference, :terms, :paid, :active, :company_id, :application_id, :job_id, :job_title, :profile_id, :profile_username, :ssyk_code)
  end

  def invoice_update_params
    params.require(:invoice).permit(:description, :quantity, :unit, :amount, :first_day, :last_day, :user_reference, :company_reference, :terms, :paid, :active, :company_id, :application_id, :job_id, :job_title, :profile_id, :profile_username)
  end

  def invoice_extend_params
    params.permit(:feedback, :terms, :post, :rating)
  end
end

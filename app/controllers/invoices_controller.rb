class InvoicesController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy, :create]
  before_action :authenticate_company!, only: [:show, :activate]

  def create
    @invoice = Invoice.new invoice_params
    @application = Application.find(params[:application_id])
    @company = @application.job.company
    @invoice.profile_id = current_user.profile.id
    @invoice.profile_username = current_user.profile.username
    @invoice.user_id = current_user.id
    @invoice.user_fee = current_user.fee
    Notification.create(recipient: @company, actor: current_user.profile, action: 'Ny', notifiable: @invoice, job_id: @application.job.id, application_id: @application.id)
    if @invoice.save

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
    @due_date = @invoice.updated_at+@invoice.terms.day
  end

  def edit
    @invoice = Invoice.find(params[:id])
  end

  def update
    @invoice = Invoice.find(params[:id])
    @company = Company.find_by(id: @invoice.company_id)
    respond_to do |format|
      if @invoice.update invoice_update_params
        Notification.create(recipient: @company, actor: current_user.profile, action: 'Ändrad', notifiable: @invoice, job_id: @invoice.job_id, application_id: @invoice.application_id)
        format.html { redirect_to edit_invoice_path(@invoice), notice: 'Faktura ändrad' }
        format.json { render :edit, status: :ok, location: @invoice }
      else
        format.html { render :edit }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  def activate
    @invoice = Invoice.find(params[:id])
    @user = @invoice.user
    @invoice.active = true
    if @invoice.update invoice_activate_params
      Notice.create(recipient: @user.profile, actor: current_company, action: 'Godkänd', notifiable: @invoice, job_id: @invoice.job_id, application_id: @invoice.application_id)
      if @invoice.post == true
        @invoice.update(amount: @invoice.amount + 500)
      end
      if @invoice.terms == 60
        @invoice.update(amount: @invoice.amount + 40)
      end

      # Sends email to user when invoice is activated.
      NotificationMailer.activate_invoice_email(@user, @invoice).deliver_now

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
    params.permit(:active, :terms, :post, :feedback)
  end
end

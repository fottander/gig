class InvoicesController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy, :create]
  before_action :authenticate_company!, only: [:show, :activate]

  def create
    @profile = Profile.find_by(user_id: current_user)
    @invoice = Invoice.new invoice_params
    @application = Application.find(params[:application_id])
    @job = Job.find_by(id: @application.job_id)
    @company = Company.find_by(id: @job.company_id)
    @invoice.profile_id = @profile.id
    @invoice.profile_username = @profile.username
    @invoice.user_id = current_user.id
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
    @profile = Profile.find_by(user_id: current_user)
    @invoice = Invoice.find(params[:id])
  end

  def update
    @invoice = Invoice.find(params[:id])
    respond_to do |format|
      if @invoice.update invoice_update_params
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
    @user = User.find_by(id: @invoice.user_id)
    @invoice.active = true
    if @invoice.update invoice_activate_params
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

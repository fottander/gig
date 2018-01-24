class AdmininvoicesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @invoices = Invoice.where(nil).paginate(page: params[:page])
    filtering_params(params).each do |key, value|
      @invoices = @invoices.public_send(key, value) if value.present?
    end
  end

  def show
    @invoice = Invoice.find(params[:id])
    @company = @invoice.company
    @profile = @invoice.user.profile
    @due_date = @invoice.updated_at+@invoice.terms.day
    respond_to do |format|
      format.html
      format.pdf do
        pdf = InvoicePdf.new(@invoice, @profile, @company, @due_date)
        send_data pdf.render, filename: "invoice_#{@invoice.id}.pdf",
                              type: 'application/pdf',
                              disposition: 'inline'
      end
    end
  end

  def edit
    @invoice = Invoice.find(params[:id])
  end

  def update
    @invoice = Invoice.find(params[:id])
    respond_to do |format|
      if @invoice.update invoice_update_params
        format.html { redirect_to edit_admininvoice_path(@invoice), notice: 'Faktura ändrad' }
        format.json { render :edit, status: :ok, location: @invoice }
      else
        format.html { render :edit }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @invoice = Invoice.find(params[:id])
    if @invoice.destroy
      flash[:notice] = "Faktura raderad!"
      redirect_to administrations_path
    end
  end

  def pay
    @invoice = Invoice.find(params[:id])
    @invoice.paid = true
    if @invoice.update invoice_pay_params
      flash[:notice] = "Faktura betald"
      redirect_back(fallback_location: administrations_path)
    end
  end

  def pay_salary
    @invoice = Invoice.find(params[:id])
    @invoice.salary_paid = true
    if @invoice.update invoice_pay_salary_params
      flash[:notice] = "Lön har blivit utbetald"
      redirect_back(fallback_location: administrations_path)
    end
  end

  def activate
    @invoice = Invoice.find(params[:id])
    @user = @invoice.user
    @invoice.active = true
    if @invoice.update invoice_activate_params

      # Sends email to user when invoice is activated.
      NotificationMailer.activate_invoice_email(@user, @invoice).deliver_now

      flash[:notice] = "Faktura godkänd och aktiverad"
      redirect_back(fallback_location: administrations_path)
    end
  end

  private

  def invoice_pay_params
    params.permit(:paid)
  end

  def invoice_pay_salary_params
    params.permit(:salary_paid)
  end

  def filtering_params(params)
    params.slice(:with_ocr, :with_user_id, :with_company_id)
  end

  def invoice_activate_params
    params.permit(:active)
  end

  def invoice_update_params
    params.require(:invoice).permit(:description, :quantity, :unit, :amount, :first_day, :last_day, :user_reference, :company_reference, :terms, :paid, :active, :company_id, :application_id, :job_id, :profile_id, :profile_username)
  end

end

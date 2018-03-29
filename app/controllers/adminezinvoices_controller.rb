class AdminezinvoicesController < ApplicationController
  before_action :authenticate_admin!

  def index
    sleep 1
    @ezinvoices = Ezinvoice.where(nil).paginate(page: params[:page])
    filtering_params(params).each do |key, value|
      @ezinvoices = @ezinvoices.public_send(key, value) if value.present?
    end
  end

  def show
    @ezinvoice = Ezinvoice.find(params[:id])
    @profile = @ezinvoice.user.profile
    respond_to do |format|
      format.html
      format.pdf do
        pdf = EzinvoicePdf.new(@ezinvoice, @profile, @due_date)
        send_data pdf.render, filename: "invoice_#{@ezinvoice.id}.pdf",
                              type: 'application/pdf',
                              disposition: 'inline'
      end
    end
  end

  def edit
    @ezinvoice = Ezinvoice.find(params[:id])
  end

  def update
    @ezinvoice = Ezinvoice.find(params[:id])
    respond_to do |format|
      if @ezinvoice.update ezinvoice_update_params
        format.html { redirect_to edit_adminezinvoice_path(@ezinvoice), notice: 'Faktura ändrad' }
        format.json { render :edit, status: :ok, location: @ezinvoice }
      else
        format.html { render :edit }
        format.json { render json: @ezinvoice.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @ezinvoice = Ezinvoice.find(params[:id])
    if @ezinvoice.destroy
      flash[:notice] = "Faktura raderad!"
      redirect_to administrations_path
    end
  end

  def pay
    @ezinvoice = Ezinvoice.find(params[:id])
    @ezinvoice.paid = true
    if @ezinvoice.update ezinvoice_pay_params
      flash[:notice] = "Faktura betald"
      redirect_back(fallback_location: administrations_path)
    end
  end

  def pay_salary
    @ezinvoice = Ezinvoice.find(params[:id])
    @ezinvoice.salary_paid = true
    if @ezinvoice.update ezinvoice_pay_salary_params
      flash[:notice] = "Lön har blivit utbetald"
      redirect_back(fallback_location: administrations_path)
    end
  end

  def activate
    @ezinvoice = Ezinvoice.find(params[:id])
    @user = @ezinvoice.user
    @ezinvoice.active = true
    if @ezinvoice.update ezinvoice_activate_params
      @invoice = @ezinvoice
      # Sends email to user when invoice is activated.
      NotificationMailer.activate_invoice_email(@user, @invoice).deliver_now

      flash[:notice] = "Faktura godkänd och aktiverad"
      redirect_back(fallback_location: administrations_path)
    end
  end

  private

  def ezinvoice_pay_params
    params.permit(:paid)
  end

  def ezinvoice_pay_salary_params
    params.permit(:salary_paid)
  end

  def filtering_params(params)
    params.slice(:with_ocr, :with_user_id)
  end

  def ezinvoice_activate_params
    params.permit(:active)
  end

  def ezinvoice_update_params
    params.require(:ezinvoice).permit(:org_number, :company_name, :company_address, :company_zip, :company_city, :company_email, :description, :quantity, :unit, :amount, :first_day, :last_day, :user_reference, :company_reference, :terms)
  end

end

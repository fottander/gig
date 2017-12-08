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
    @companies = Company.where(id: @invoice.company_id)
    @profiles = Profile.where(id: @invoice.profile_id)
    @due_date = @invoice.updated_at+@invoice.terms.day
    respond_to do |format|
      format.html
      format.pdf do
        pdf = InvoicePdf.new(@invoice, @profiles, @companies, @due_date)
        send_data pdf.render, filename: "invoice_#{@invoice.id}.pdf",
                              type: 'application/pdf',
                              disposition: 'inline'
      end
    end
  end

  def pay
    @invoice = Invoice.find(params[:id])
    @invoice.paid = true
    if @invoice.update invoice_pay_params

      # Sends email to company when invoice is paid.

      flash[:notice] = "Faktura betald"
      redirect_back(fallback_location: administrations_path)
    end
  end

  private

  def invoice_pay_params
    params.permit(:paid)
  end

  def filtering_params(params)
    params.slice(:with_id, :with_user_id, :with_company_id)
  end

end

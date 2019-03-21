class AdminpaymentsController < ApplicationController
  before_action :authenticate_admin!

  def index
    sleep 1
    @invoices = Invoice.where(nil).paginate(page: params[:page])
    filtering_params(params).each do |key, value|
      @invoices = @invoices.public_send(key, value) if value.present?
    end
  end

  def show
    @invoice = Invoice.find(params[:id])
    @company = @invoice.company
    @user = @invoice.user
    @profile = @user.profile
    respond_to do |format|
      format.html
      format.pdf do
        pdf = PaymentPdf.new(@invoice, @user, @profile, @company)
        send_data pdf.render, filename: "invoice_#{@invoice.id}.pdf",
                              type: 'application/pdf',
                              disposition: 'inline'
      end
    end
  end

  def new
    @invoices = Invoice.where(nil).paginate(page: params[:page])
    filtering_params(params).each do |key, value|
      @invoices = @invoices.public_send(key, value) if value.present?
    end
  end

  private

  def filtering_params(params)
    params.slice(:with_ocr, :with_user_id, :with_company_id)
  end
end

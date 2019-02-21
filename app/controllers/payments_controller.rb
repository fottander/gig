class PaymentsController < ApplicationController
  before_action :authenticate_user!
  def index
    @invoices = Invoice.where(profile_id: current_user.profile.id)
    @invoices_salary_paid = @invoices.salary_paid.paginate(page: params[:salary_paid])
    @invoices_salary_not_paid = @invoices.salary_not_paid.paginate(page: params[:salary_not_paid])
    @ezinvoices = Ezinvoice.where(profile_id: current_user.profile.id)
    @ezinvoices_salary_paid = @ezinvoices.salary_paid.paginate(page: params[:ez_salary_paid])
    @ezinvoices_salary_not_paid = @ezinvoices.salary_not_paid.paginate(page: params[:ez_salary_not_paid])
    render layout: 'mobile_scroll_layout'
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
end

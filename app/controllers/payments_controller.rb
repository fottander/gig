class PaymentsController < ApplicationController
  before_action :authenticate_user!
  def index
    @invoices = Invoice.where(profile_id: current_user.profile.id)
    @invoices_salary_paid = @invoices.salary_paid.paginate(page: params[:salary_paid])
    @invoices_salary_not_paid = @invoices.salary_not_paid.paginate(page: params[:salary_not_paid])
    @ezinvoices = Ezinvoice.where(profile_id: current_user.profile.id)
    @ezinvoices_salary_paid = @ezinvoices.salary_paid.paginate(page: params[:ez_salary_paid])
    @ezinvoices_salary_not_paid = @ezinvoices.salary_not_paid.paginate(page: params[:ez_salary_not_paid])
  end

  def show
    @invoice = Invoice.find(params[:id])
  end
end

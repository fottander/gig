class AdministrationsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @categories = Category.all.paginate(page: params[:categories])
    @cities = City.all.paginate(page: params[:cities])
    @invoices = Invoice.paginate(page: params[:invoices])
    @ezinvoices = Ezinvoice.paginate(page: params[:ezinvoices])
    @jobs = Job.first(10)
    @applications = Application.hired.first(10)
    @companies = Company.first(10)
  end
end

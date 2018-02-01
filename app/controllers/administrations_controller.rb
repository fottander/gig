class AdministrationsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @categories = Category.all.paginate(page: params[:categories], per_page: 4)
    @invoices = Invoice.not_active.paginate(page: params[:invoices])
    @ezinvoices = Ezinvoice.not_active.paginate(page: params[:ezinvoices])
    @jobs = Job.last(10)
    @profiles = Profile.last(10)
    @companies = Company.last(10)
  end
end

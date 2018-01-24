class AdministrationsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @categories = Category.all
    @invoices = Invoice.not_active.paginate(page: params[:page])
    @ezinvoices = Ezinvoice.not_active.paginate(page: params[:page])
    @jobs = Job.last(10)
    @profiles = Profile.last(10)
    @companies = Company.last(10)
  end
end

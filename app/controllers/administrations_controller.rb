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
    @job_count = Job.all.count.to_f
    @application_count = Application.all.count.to_f
    @hire_count = Application.hired.count.to_f
    @applications_per_job = @application_count / @job_count
    @hires_per_job = @hire_count / (@job_count - 4)
  end
end

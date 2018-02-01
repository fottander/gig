class PanelsController < ApplicationController
  before_action :authenticate_company!
  def index
    @jobs = Job.where(company_id: current_company).paginate(page: params[:jobs], per_page: 4)
    @applications = Application.where(job_id: @jobs)
    @applications_hired = @applications.hired.paginate(page: params[:hired])
    @applications_complete = @applications.complete.paginate(page: params[:complete])
    @invoices = Invoice.where(company_id: current_company.id).paginate(page: params[:invoices], per_page: 4)
    @activities = PublicActivity::Activity.order('created_at desc').where(recipient_id: current_company.id, recipient_type: 'Company')
  end
end

class PanelsController < ApplicationController
  before_action :authenticate_company!
  def index
    @jobs = Job.where(company_id: current_company).paginate(page: params[:active_jobs], per_page: 4)
    @applications = Application.where(company_id: current_company.id)
    @applications_hired = @applications.hired.paginate(page: params[:hired])
    @applications_complete = @applications.complete.paginate(page: params[:complete])
    @invoices = Invoice.where(company_id: current_company.id).paginate(page: params[:invoices])
    @activities = PublicActivity::Activity.order('created_at desc').where(recipient_id: current_company.id, recipient_type: 'Company').includes(:owner, :trackable).last(10)
  end
end

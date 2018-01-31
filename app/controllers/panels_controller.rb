class PanelsController < ApplicationController
  before_action :authenticate_company!
  def index
    @jobs = Job.where(company_id: current_company)
    @applications = Application.where(job_id: @jobs)
    @invoices = Invoice.where(company_id: current_company.id)
    @activities = PublicActivity::Activity.order('created_at desc').where(recipient_id: current_company.id, recipient_type: 'Company')
  end
end

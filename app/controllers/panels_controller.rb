class PanelsController < ApplicationController
  before_action :authenticate_company!
  def index
    @job = Job.where(company_id: current_company)
    @application = Application.where(job_id: @job)
    @invoices = Invoice.where(company_id: current_company.id)
  end
end

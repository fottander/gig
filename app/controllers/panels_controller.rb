class PanelsController < ApplicationController
  before_action :authenticate_company!
  def index
    @job = Job.where(company_id: current_company)
  end
end

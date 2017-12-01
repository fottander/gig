class AdministrationsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @categories = Category.all
    @invoices = Invoice.last(10)
    @jobs = Job.last(10)
  end
end

class DashboardsController < ApplicationController
  before_action :authenticate_user!
  def index
    @applications = Application.where(profile_id: current_user.profile)
    @invoices = Invoice.where(user_id: current_user)
    @jobs = Job.where(id: @applications.pluck(:job_id))
    @activities = PublicActivity::Activity.order('created_at desc').where(recipient_id: current_user.id, recipient_type: 'Profile')
  end
end

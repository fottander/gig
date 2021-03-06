class DashboardsController < ApplicationController
  before_action :authenticate_user!
  def index
    @applications = Application.where(profile_id: current_user.profile)
    @applications_not_hired = @applications.not_hired.paginate(page: params[:not_hired])
    @applications_hired = @applications.hired.paginate(page: params[:hired])
    @applications_complete = @applications.complete.paginate(page: params[:complete])
    @invoices = Invoice.where(user_id: current_user).paginate(page: params[:invoices])
    @activities = PublicActivity::Activity.order('created_at desc').where(recipient_id: current_user.id, recipient_type: 'Profile').includes(:owner, :trackable).first(10)
    render layout: 'mobile_scroll_layout'
  end
end

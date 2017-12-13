class NotificationsController < ApplicationController
  before_action :authenticate_company!
  def index
    @notifications = Notification.where(recipient: current_company)
  end
end

class NotificationsController < ApplicationController
  before_action :authenticate_company!
  def index
    @notifications = Notification.where(recipient_id: current_company).unread
  end
end

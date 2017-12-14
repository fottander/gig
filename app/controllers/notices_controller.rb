class NoticesController < ApplicationController
  before_action :authenticate_user!
  def index
    @notices = Notice.where(recipient: current_user)
  end
end

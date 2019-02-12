class FaqsController < ApplicationController
  def index
    add_breadcrumb 'Start', :root_path
    add_breadcrumb 'Vanliga frågor'
    render layout: 'mobile_scroll_layout'
  end
end

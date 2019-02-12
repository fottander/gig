class WhyUsController < ApplicationController
  def index
    add_breadcrumb 'Start', :root_path
    add_breadcrumb 'Varför Qnekt?'
    render layout: 'mobile_scroll_layout'
  end
end

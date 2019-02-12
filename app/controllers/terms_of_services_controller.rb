class TermsOfServicesController < ApplicationController
  def index
    add_breadcrumb 'Start', :root_path
    add_breadcrumb 'Våra villkor'
    render layout: 'mobile_scroll_layout'
  end
end

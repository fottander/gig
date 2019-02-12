class OurRatesController < ApplicationController
  def index
    add_breadcrumb 'Start', :root_path
    add_breadcrumb 'Våra avgifter'
    render layout: 'mobile_scroll_layout'
  end
end

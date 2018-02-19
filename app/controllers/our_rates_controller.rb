class OurRatesController < ApplicationController
  def index
    add_breadcrumb 'Start', :root_path
    add_breadcrumb 'Våra avgifter'
  end
end

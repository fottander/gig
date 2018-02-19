class TermsOfServicesController < ApplicationController
  def index
    add_breadcrumb 'Start', :root_path
    add_breadcrumb 'Våra villkor'
  end
end

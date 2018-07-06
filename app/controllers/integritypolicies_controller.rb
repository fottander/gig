class IntegritypoliciesController < ApplicationController
  def index
    add_breadcrumb 'Start', :root_path
    add_breadcrumb 'Våra villkor', :terms_of_services_path
    add_breadcrumb 'Våra avgifter'
  end
end

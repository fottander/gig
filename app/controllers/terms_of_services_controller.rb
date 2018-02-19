class TermsOfServicesController < ApplicationController
  def index
    add_breadcrumb 'Start', :root_path
    add_breadcrumb 'Kontakta oss'
  end
end

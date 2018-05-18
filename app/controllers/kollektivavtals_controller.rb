class KollektivavtalsController < ApplicationController
  def index
    add_breadcrumb 'Start', :root_path
    add_breadcrumb 'Användarvillkor', :terms_of_services_path
    add_breadcrumb 'Kollektivavtal'
  end
end

class WhyFreelancesController < ApplicationController
  def index
    add_breadcrumb 'Start', :root_path
    add_breadcrumb 'Varför frilansare?'
  end
end

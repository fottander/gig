class WhyUsController < ApplicationController
  def index
    add_breadcrumb 'Start', :root_path
    add_breadcrumb 'Varför ANewBiz?'
  end
end

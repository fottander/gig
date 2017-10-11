class JobsController < ApplicationController
  before_action :authenticate_company!
  
  def new

  end
end

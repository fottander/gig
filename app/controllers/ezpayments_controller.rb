class EzpaymentsController < ApplicationController
  before_action :authenticate_user!

  def show
    @ezinvoice = Ezinvoice.find(params[:id])
  end
end

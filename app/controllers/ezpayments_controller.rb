class EzpaymentsController < ApplicationController
  before_action :authenticate_user!

  def show
    @profile = Profile.find_by(user_id: current_user)
    @ezinvoice = Ezinvoice.find(params[:id])
  end
end

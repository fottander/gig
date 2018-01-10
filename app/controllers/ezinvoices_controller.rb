class EzinvoicesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def new
    @profile = current_user.profile
    @ezinvoice = Ezinvoice.new
  end

  def create
    @profile = current_user.profile
    @ezinvoice = Ezinvoice.new ezinvoice_params
    @ezinvoice.user_id = current_user.id
    @ezinvoice.profile_id = @profile.id
    @ezinvoice.profile_username = @profile.username
    respond_to do |format|
      if @ezinvoice.save
        format.html { redirect_to new_ezinvoice_path, notice: 'Ny faktura skapad!' }
        format.json { render :new, status: :created}
      else
        format.html { render :new }
        format.json { render json: @ezinvoice.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def ezinvoice_params
    params.require(:ezinvoice).permit(:org_number, :company_name, :company_address, :company_zip, :company_city, :company_email, :description, :quantity, :unit, :amount, :first_day, :last_day, :user_reference, :company_reference)
  end

end

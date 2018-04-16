class EzinvoicesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :index, :edit, :update, :destroy]

  def index
    @ezinvoices = Ezinvoice.where(user_id: current_user.id).paginate(page: params[:page])
  end

  def new
    @ezinvoice = Ezinvoice.new
  end

  def create
    @ezinvoice = Ezinvoice.new ezinvoice_params
    @ezinvoice.user_id = current_user.id
    @ezinvoice.profile_id = current_user.profile.id
    @ezinvoice.profile_username = current_user.profile.username
    @ezinvoice.user_fee = current_user.fee
    respond_to do |format|
      if @ezinvoice.save
        format.html { redirect_to ezinvoices_path, notice: 'Ny faktura skapad!' }
        format.json { render :new, status: :created}
      else
        format.html { render :new }
        format.json { render json: @ezinvoice.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @ezinvoice = Ezinvoice.find(params[:id])
  end

  def update
    @ezinvoice = Ezinvoice.find(params[:id])
    respond_to do |format|
      if @ezinvoice.update ezinvoice_update_params
        format.html { redirect_to edit_ezinvoice_path(@ezinvoice), notice: 'Faktura ändrad' }
        format.json { render :edit, status: :ok, location: @ezinvoice }
      else
        format.html { render :edit }
        format.json { render json: @ezinvoice.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @ezinvoice = Ezinvoice.find(params[:id])
    if @ezinvoice.destroy
      flash[:notice] = "Faktura raderad!"
      redirect_back(fallback_location: dashboards_path)
    else
      flash[:alert] = 'Något gick fel. Försök igen eller kontakta kundtjänst.'
      redirect_back(fallback_location: dashboards_path)
    end
  end

  private

  def ezinvoice_update_params
    params.require(:ezinvoice).permit(:org_number, :company_name, :company_address, :company_zip, :company_city, :company_email, :description, :quantity, :unit, :amount, :first_day, :last_day, :user_reference, :company_reference, :terms, :ssyk_code)
  end

  def ezinvoice_params
    params.require(:ezinvoice).permit(:org_number, :company_name, :company_address, :company_zip, :company_city, :company_email, :description, :quantity, :unit, :amount, :first_day, :last_day, :user_reference, :company_reference, :terms, :ssyk_code)
  end

end

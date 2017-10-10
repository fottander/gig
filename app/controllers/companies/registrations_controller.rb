class Companies::RegistrationsController < Devise::RegistrationsController
  def create
    super
  end

  private

  def sign_up_params
    params.require(:company).permit(:email, :name, :address, :zip_code, :city, :org_number, :phone, :password, :password_confirmation)
  end
end

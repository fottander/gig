class Companies::RegistrationsController < Devise::RegistrationsController
  before_action :configure_account_update_params, only: [:update]

  def create
    super
  end

  def update
    super
  end

  private

  def configure_account_update_params
   devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :address, :zip_code, :city, :org_number, :phone, :password, :password_confirmation])
  end

  def sign_up_params
    params.require(:company).permit(:email, :name, :address, :zip_code, :city, :org_number, :phone, :password, :password_confirmation)
  end
end

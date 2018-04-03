class Companies::RegistrationsController < Devise::RegistrationsController
  before_action :configure_account_update_params, only: [:update]

  def create
    super
    if @company.persisted?
      NotificationMailer.company_registration_email(@company).deliver_now
    end
  end

  def update
    super
  end

  private

  def configure_account_update_params
   devise_parameter_sanitizer.permit(:account_update, keys: [:name, :username, :email, :address, :zip_code, :city, :org_number, :phone, :contact, :invoice_address, :password, :password_confirmation])
  end

  def sign_up_params
    params.require(:company).permit(:email, :name, :username, :address, :zip_code, :city, :org_number, :phone, :contact, :password, :password_confirmation)
  end
end

class Admins::RegistrationsController < Devise::RegistrationsController
  before_action :configure_account_update_params, only: [:update]
  before_action :authenticate_admin!

  def edit
    super
  end

  def update
    super
  end

  protected

  def configure_account_update_params
   devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :password_confirmation])
  end

end

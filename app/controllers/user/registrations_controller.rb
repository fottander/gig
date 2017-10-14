class User::RegistrationsController < Devise::RegistrationsController
  before_action :configure_account_update_params, only: [:update]

  def create
    super
  end
  
  def update
   super
  end

  protected

  def configure_account_update_params
   devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :phone])
  end

end

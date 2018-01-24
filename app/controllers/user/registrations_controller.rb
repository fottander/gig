class User::RegistrationsController < Devise::RegistrationsController
  before_action :configure_account_update_params, only: [:update]

  def create
    super
  end

  def update
   super
  end

  def edit
    super
  end

  protected

  def configure_account_update_params
   devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :phone, :pers_num, :bank, :clear_nr, :account_nr])
  end

end

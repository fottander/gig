class User::RegistrationsController < Devise::RegistrationsController
  before_action :configure_account_update_params, only: [:update]

  def create
    super
  end

  def update
   super
  end

  def edit
    @profile = Profile.find_by(user_id: current_user)
    super
  end

  protected

  def configure_account_update_params
   devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :phone, :bank, :clear_nr, :account_nr])
  end

end

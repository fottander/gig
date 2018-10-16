class User::RegistrationsController < Devise::RegistrationsController
  before_action :configure_account_update_params, only: [:update]
  before_action :sign_up_params, only: [:create]

  def new
    super
  end

  def create
    super
    if @user.persisted?
      flash[:notice] = "Registrerad! Kolla din mail efter vår bekräftelse och följ instruktionerna. Ibland hamnar det i skräpposten, vänligen markera då mailet som ej spam för att ta emot viktiga emails för ditt konto."
      NotificationMailer.user_registration_email(@user).deliver_now
    end
  end

  def update
   super
  end

  def edit
    super
  end

  def destroy
    super
  end

  def cancel
    super
  end

  protected

  def after_inactive_sign_up_path_for(resource_or_scope)
    new_user_session_path
  end

  def configure_account_update_params
   devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :phone, :pers_num, :bank, :clear_nr, :account_nr])
  end

  def sign_up_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
  end

end

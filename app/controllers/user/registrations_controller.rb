class User::RegistrationsController < Devise::RegistrationsController
  before_action :configure_account_update_params, only: [:update]
  before_action :sign_up_params, only: [:create]
  before_action :authenticate_user!, except: [:new, :create]

  def new
    super
  end

  def create
    super
    if @user.persisted?
      flash[:notice] = "Snart klar! Aktivera ditt konto genom att följa instruktionerna i det bekräftelse email vi skickat till #{@user.email}. Ibland hamnar det i skräpposten, vänligen markera då mailet som ej spam för att ta emot viktiga emails för ditt konto."
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

  def update_resource(resource, params)
    # Require current password if user is trying to change password.
    return super if params["password"]&.present?

    # Allows user to update registration information without password.
    resource.update_without_password(params.except("current_password"))
  end

end

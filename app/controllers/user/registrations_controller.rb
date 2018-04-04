class User::RegistrationsController < Devise::RegistrationsController
  before_action :configure_account_update_params, only: [:update]

  def new
    super
  end

  def create
    super
    if @user.persisted?
      flash[:notice] = "Du är registrerad! Bekräfta att du fått vårt Välkommen email. Ibland hamnar det i skräpposten, vänligen markera då mailet som ej spam för att ta emot viktiga emails för ditt konto."
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

  def configure_account_update_params
   devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :phone, :pers_num, :bank, :clear_nr, :account_nr])
  end

end

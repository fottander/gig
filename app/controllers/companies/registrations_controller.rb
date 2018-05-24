class Companies::RegistrationsController < Devise::RegistrationsController
  before_action :configure_account_update_params, only: [:update]
  before_action :sign_up_params, only: [:create]

  def new
    super
  end

  def create
    super
    if @company.persisted?
      flash[:notice] = "Du är registrerad! Bekräfta att du fått vårt Välkommen email. Ibland hamnar det i skräpposten, vänligen markera då mailet som ej spam för att ta emot viktiga emails för ditt konto."
      NotificationMailer.company_registration_email(@company).deliver_now
    end
  end

  def edit
    super
  end

  def update
    super
  end

  def destroy
    super
  end

  def cancel
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

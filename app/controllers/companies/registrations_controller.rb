class Companies::RegistrationsController < Devise::RegistrationsController
  before_action :configure_account_update_params, only: [:update]
  before_action :sign_up_params, only: [:create]
  before_action :authenticate_company!, except: [:new, :create]

  def new
    super
  end

  def create
    super
    if @company.persisted?
      flash[:notice] = "Snart klar! Aktivera ditt konto genom att följa instruktionerna i det bekräftelse email vi skickat till #{@company.email}. Ibland hamnar det i skräpposten, vänligen markera då mailet som ej spam för att ta emot viktiga emails för ditt konto."
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

  protected

  def after_inactive_sign_up_path_for(resource_or_scope)
    new_job_path
  end

  def configure_account_update_params
   devise_parameter_sanitizer.permit(:account_update, keys: [:name, :username, :email, :address, :zip_code, :city, :org_number, :phone, :invoice_address, :description, :employees, :password, :password_confirmation])
  end

  def sign_up_params
    params.require(:company).permit(:email, :name, :username, :address, :zip_code, :city, :org_number, :phone, :contact, :password, :password_confirmation)
  end

  def update_resource(resource, params)
    # Require current password if user is trying to change password.
    return super if params["password"]&.present?

    # Allows user to update registration information without password.
    resource.update_without_password(params.except("current_password"))
  end
end

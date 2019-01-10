class AdminCompaniesController < Devise::RegistrationsController
  before_action :authenticate_admin!
  before_action :sign_up_params, only: [:create]

  def new
    super
  end

  def create
    build_resource(sign_up_params)
    resource.skip_confirmation!
    resource.confirm
    resource.real = false
    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  def show
    @company = Company.find(params[:id])
    @jobs = Job.where(id: @company.id)
  end

  protected

  def sign_up_params
    params.require(:company).permit(:email, :name, :username, :address, :zip_code, :city, :org_number, :phone, :contact, :password, :password_confirmation)
  end

  def after_sign_up_path_for(resource)
    administrations_path
  end

end

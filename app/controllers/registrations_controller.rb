class RegistrationsController < Devise::RegistrationsController

  def create
    super
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :role, :first_name, :last_name, :phone, :password, :password_confirmation)
  end
end

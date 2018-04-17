class Admins::RegistrationsController < Devise::RegistrationsController

  def new
    super
  end

  def create
    super
  end

  private

  def sign_up_params
    params.require(:admin).permit(:email, :password, :password_confirmation)
  end
end

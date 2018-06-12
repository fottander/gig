class UsersController < ApplicationController
  before_action :authenticate_admin!
  def index
    sleep 1
    @users = User.where(nil).includes(:profile).paginate(page: params[:page])
    filtering_params(params).each do |key, value|
      @users = @users.public_send(key, value) if value.present?
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update user_params
        format.html { redirect_to edit_user_path(@user), notice: 'User redigerad!' }
        format.json { render :edit, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = "Användare raderad"
      redirect_back(fallback_location: administrations_path)
    else
      flash[:alert] = 'Något gick fel. Försök igen eller kontakta kundtjänst.'
      redirect_back(fallback_location: administrations_path)
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :phone, :pers_num, :bank, :clear_nr, :account_nr)
  end

  def filtering_params(params)
    params.slice(:with_email, :with_id)
  end
end

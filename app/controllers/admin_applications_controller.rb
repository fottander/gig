class AdminApplicationsController < ApplicationController
  before_action :authenticate_admin!

  def show
    @application = Application.find(params[:id])
    @comments = Comment.where(application_id: @application.id)
  end

  def edit
    @application = Application.find(params[:id])
  end

  def update
    @application = Application.find(params[:id])
    respond_to do |format|
      if @application.update admin_application_params
        format.html { redirect_to edit_admin_application_path(@application), notice: 'Ansökan ändrad' }
        format.json { render :edit, status: :ok, location: @application }
      else
        format.html { render :edit }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def admin_application_params
    params.require(:application).permit(:message, :first_day, :last_day, :add_ob)
  end

end

class CitiesController < ApplicationController
  before_action :authenticate_admin!

  def create
    @city = City.new city_params
    if @city.save
      flash[:notice] = "Stad skapad"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = 'Fyll i alla fält korrekt!'
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
    @city = City.find(params[:id])
  end

  def update
    @city = City.find(params[:id])
    respond_to do |format|
      if @city.update city_update_params
        format.html { redirect_to root_path, notice: 'Stad redigerad!' }
        format.json { render :edit, status: :ok}
      else
        format.html { render :edit }
        format.json { render json: @city.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @city = City.find(params[:id])
    if @city.destroy
      flash[:notice] = "Stad raderad!"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = 'Något gick fel. Försök igen eller kontakta kundtjänst.'
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def city_update_params
    params.require(:city).permit(:name)
  end

  def city_params
    params.permit(:name)
  end

end

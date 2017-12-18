class CategoriesController < ApplicationController
  before_action :authenticate_admin!

  def create
    @category = Category.new category_params
    if @category.save
      flash[:notice] = "Kategori skapad"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = 'Fyll i alla fält korrekt!'
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    respond_to do |format|
      if @category.update category_update_params
        format.html { redirect_to root_path, notice: 'Kategori redigerad!' }
        format.json { render :edit, status: :ok}
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      flash[:notice] = "Kategori raderad!"
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def category_update_params
    params.require(:category).permit(:name, :avatar)
  end

  def category_params
    params.permit(:name, :avatar)
  end

end

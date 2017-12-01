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

  private

  def category_params
    params.permit(:name)
  end

end

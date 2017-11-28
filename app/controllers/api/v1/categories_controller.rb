class Api::V1::CategoriesController < ApiController
  def index
    @categories = Category.all
  end
end

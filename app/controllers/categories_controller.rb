class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @venues = @category.venues
  end
end

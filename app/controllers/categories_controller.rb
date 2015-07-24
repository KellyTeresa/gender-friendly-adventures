class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @venues = @category.venues.where(
      approved: true).order(:name)
  end
end

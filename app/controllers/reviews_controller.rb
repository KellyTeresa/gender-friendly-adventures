class ReviewsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  def new
    @business = Business.find(params[:business_id])
    @review = Review.new
  end

  def create
  end
end

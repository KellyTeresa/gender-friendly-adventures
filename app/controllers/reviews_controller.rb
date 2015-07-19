class ReviewsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def new
    @venue = Venue.find(params[:venue_id])
    @review = Review.new
  end

  def create
    @venue = Venue.find(params[:venue_id])
    @review = Review.new(review_params)
    @review.venue = @venue
    @review.user = current_user

    if @review.save
      flash[:success] = "Review added!"
      redirect_to venue_path(@venue)
    else
      announce_errors(@review)
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(
      :terminology,
      :bathrooms,
      :gv_staff,
      :overall,
      :comment
    )
  end
end

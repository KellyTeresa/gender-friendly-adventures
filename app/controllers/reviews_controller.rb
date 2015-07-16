class ReviewsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  def new
    @business = Business.find(params[:business_id])
    @review = Review.new
  end

  def create
    @business = Business.find(params[:business_id])
    @review = Review.new(review_params)
    @review.business = @business
    @review.user = current_user

    if @review.save
      flash[:success] = "Review added!"
      redirect_to business_path(@business)
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

  def announce_errors(review)
    count = review.errors.count
    flash[:alert] = %(
      #{count} #{'error'.pluralize(count)}
      prohibited this review from being saved:
      #{review.errors.full_messages.join('. ')}
    )
  end
end

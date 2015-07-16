class BusinessesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @businesses = Business.all
  end

  def show
    @business = Business.find(params[:id])
  end

  def new
    @business = Business.new
  end

  def create
    @business = Business.new(business_params)
    if @business.save
      flash[:success] = 'Venue saved'
      redirect_to business_path(@business)
    else
      announce_errors(@business)
      render :new
    end
  end

  private

  def business_params
    params.require(:business).permit(
      :name,
      :address,
      :summary,
      :description,
      :website,
      :phone_number
    )
  end

  def announce_errors(venue)
    count = venue.errors.count
    flash[:alert] = %(
      #{count} #{'error'.pluralize(count)}
      prohibited this venue from being saved:
      #{venue.errors.full_messages.join('. ')}
    )
  end
end

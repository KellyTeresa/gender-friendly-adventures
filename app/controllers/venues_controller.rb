class VenuesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @venues = Venue.all
  end

  def show
    @venue = Venue.find(params[:id])
  end

  def new
    @venue = Venue.new
  end

  def create
    @venue = Venue.new(venue_params)
    if @venue.save
      flash[:success] = 'Venue saved'
      redirect_to venue_path(@venue)
    else
      announce_errors(@venue)
      render :new
    end
  end

  private

  def venue_params
    params.require(:venue).permit(
      :name,
      :street_address,
      :city,
      :state,
      :zip_code,
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

class venuesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @venues = venue.all
  end

  def show
    @venue = venue.find(params[:id])
  end

  def new
    @venue = venue.new
  end

  def create
    @venue = venue.new(venue_params)
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

class VenuesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :authorize, only: [:edit, :update, :destroy]

  def index
    @categories = Category.all.order(:name)
    if params[:q] == ''
      flash[:alert] = "Please specify a search phrase"
      redirect_to (:back || root_path)
    elsif params[:q].present?
      @venues = Venue.search(params[:q]).where(
        approved: true).order(params[:loc] || :name)
    else
      @venues = Venue.all.where(
        approved: true).order(params[:loc] || :name)
    end
  end

  def show
    @venue = Venue.find(params[:id])
    @categories = @venue.categories
  end

  def new
    @venue = Venue.new
    @categories = Category.all
  end

  def create
    @venue = Venue.new(venue_params)
    @categories = Category.all
    @user = current_user
    if @user.admin?
      @venue.approved = true
    end

    if @venue.save
      if @venue.approved?
        flash[:success] = "Venue added."
        redirect_to venue_path(@venue)
      else
        flash[:success] = "Venue queued for approval."
        redirect_to venues_path
      end
    else
      announce_errors(@venue)
      render :new
    end
  end

  def edit
    @venue = Venue.find(params[:id])
    @categories = Category.all
  end

  def update
    @venue = Venue.find(params[:id])
    @categories = Category.all
    @venue.approved = true
    if @venue.save
      flash[:success] = "Venue updated."
      redirect_to venue_path(@venue)
    else
      announce_errors(@venue)
      render :new
    end
  end

  def destroy

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
      :phone_number,
      category_ids: []
    )
  end
end

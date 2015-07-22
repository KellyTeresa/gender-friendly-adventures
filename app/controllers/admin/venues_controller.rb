class Admin::VenuesController < AdminController
  def index
    @venues = Venue.all.where(
      approved: false).order(created_at: :asc)
  end

  def show
    @venue = Venue.find(params[:id])
    @categories = @venue.categories
  end

  def edit
    @venue = Venue.find(params[:id])
    @venue.approved = true
    @venue.save
    flash[:success] = "Venue approved."
    redirect_to admin_venues_path
  end
end

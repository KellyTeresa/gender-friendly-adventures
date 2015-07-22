class AdminController < ApplicationController
  before_filter :authorize

  private

  def authorize
    if current_user == nil || !current_user.admin?
      redirect_to root_path
      flash[:alert] = "You must be signed in as an admin to view this page."
    end
  end
end

class Admin::DashboardController < AdminController
  def index
    @admin = current_user
  end
end

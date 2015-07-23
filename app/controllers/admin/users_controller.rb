class Admin::UsersController < AdminController
  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      flash[:alert] = "You cannot change your own admin status."
    elsif params[:status] == "add"
      @user.admin = true
      flash[:success] = "Admin added."
    elsif params[:status] == "remove"
      @user.admin = false
      flash[:success] = "Admin removed."
    end
    @user.save
    redirect_to admin_users_path
  end
end

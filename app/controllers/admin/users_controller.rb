class Admin::UsersController < AdminController
  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      flash[:alert] = "You cannot change your own admin status."
    else
      admin_update(@user, params[:status])
    end
    redirect_to admin_users_path
  end

  private

  def admin_update(user, status)
    if status == "add"
      user.admin = true
      flash[:success] = "Admin added."
    elsif status == "remove"
      user.admin = false
      flash[:success] = "Admin removed."
    end
    user.save
  end
end

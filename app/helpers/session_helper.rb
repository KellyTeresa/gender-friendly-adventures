module SessionHelper
  def user_has_access?(user, item)
    user && (user.admin? || user == item.user)
  end
end

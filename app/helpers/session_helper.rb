module SessionHelper
  def possessive_pronoun_display(user)
    if current_user == user
      "Your"
    else
      user.pronoun_possessive.capitalize
    end
  end
end

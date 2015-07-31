module SessionHelper
  def adjective_pronoun_display(user)
    if current_user == user
      "Your"
    else
      user.pronoun_adjective.capitalize
    end
  end
end

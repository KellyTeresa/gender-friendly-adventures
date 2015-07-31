class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  def announce_errors(item)
    count = item.errors.count
    flash[:alert] = %(
      #{count} #{'error'.pluralize(count)}
      prohibited this #{item.class.name.downcase} from being saved:
      #{item.errors.full_messages.join('. ')}
    )
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) <<
      [:display_name]

    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(
        :display_name,
        :password,
        :password_confirmation,
        :current_password,
        :gender,
        :pronoun_object,
        :pronoun_subject,
        :pronoun_adjective,
        :pronoun_reflexive,
        :pronoun_possessive
      )
    end
  end

  def authorize
    if current_user == nil || !current_user.admin?
      redirect_to root_path
      flash[:alert] = "You must be signed in as an admin to view this page."
    end
  end
end

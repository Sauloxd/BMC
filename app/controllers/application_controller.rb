class ApplicationController < ActionController::Base
  # def authenticate_user!
  #   return if current_user

  #   redirect_to new_user_session_path
  # end

  protect_from_forgery with: :exception, prepend: true

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name]  )
  end
end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, prepend: true

  before_action :configure_permitted_parameters, if: :devise_controller?
  
  rescue_from ActionPolicy::Unauthorized, with: :rescue_not_authorized

  protected

  def rescue_not_authorized
    respond_to do |f|
      f.turbo_stream do
        @toast = { message: t(:unauthorized) }
        render 'components/toasts/error', status: :unauthorized
      end
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :avatar]  )
  end
end

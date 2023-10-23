class ApplicationController < ActionController::API
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name bio age image level])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name bio age image level])
  end
end

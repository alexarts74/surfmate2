class ApplicationController < ActionController::API
  prepend_before_action :require_no_authentication, only: [:new, :create, :cancel]
  prepend_before_action :authenticate_scope!, only: [:edit, :update, :destroy]

  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name bio age image level])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name bio age image level])
  end
end

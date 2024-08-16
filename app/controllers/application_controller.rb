require "application_responder"

class ApplicationController < ActionController::API
    before_action :log_application_info

    def log_application_info
        puts "Requête reçue dans ApplicationController"
        puts "Contrôleur : #{params[:controller]}"
        puts "Action : #{params[:action]}"
    end
  self.responder = ApplicationResponder
  respond_to :json  # Puisque vous développez une API, vous pouvez vous concentrer sur JSON

  # Vous pouvez retirer ces lignes si vous ne les utilisez pas dans votre API
  # prepend_before_action :require_no_authentication, only: [:new, :create, :cancel]
  # prepend_before_action :authenticate_scope!, only: [:edit, :update, :destroy]

  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    if params[:user].present?
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :bio, :age, :image, :level])
        devise_parameter_sanitizer.permit(:account_update, keys: [:name, :bio, :age, :image, :level])
    end
  end
end

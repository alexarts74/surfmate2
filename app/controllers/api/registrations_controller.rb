class Api::RegistrationsController < Devise::RegistrationsController
    include ActionController::MimeResponds
    respond_to :json

    # skip_before_action :verify_authenticity_token
    skip_before_action :authenticate_scope!, only: [:destroy]
    before_action :authenticate_user_from_token!, only: [:destroy]

    def log_request_info
        puts "Requête reçue dans RegistrationsController"
        puts "Méthode : #{request.method}"
        puts "Chemin : #{request.path}"
        puts "Headers : #{request.headers.to_h.select { |k, v| k.start_with?('HTTP_') }}"
      end

    def create
        puts "In create session"
        build_resource(sign_up_params)
        if resource.save
            render json: { message: 'Inscription réussie !', user: resource }
        else
            render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
        end
    end

    # def destroy
    #     puts "In destory registration"
    #     # @user = current_user
    #     if current_user
    #       puts "Utilisateur connecté : #{current_user.email}"
    #       current_user.destroy
    #     #   sign_out(current_user)
    #       render json: { message: 'Compte supprimé avec succès.' }, status: :ok
    #     else
    #       render json: { error: 'Aucun utilisateur connecté.' }, status: :unprocessable_entity
    #     end
    # end

    def destroy
        puts "In destroy registration"
        puts "Utilisateur connecté : #{current_user.email}"
        begin
          current_user.destroy_messages
          current_user.destroy
          render json: { message: "Compte supprimé avec succès" }, status: :ok
        rescue => e
          puts "Erreur lors de la suppression : #{e.message}"
          render json: { error: "Erreur lors de la suppression du compte: #{e.message}" }, status: :unprocessable_entity
        end
    end
    private

    def authenticate_user_from_token!
        puts "Authentification du token"
        full_token = request.headers['Authorization']
        puts "Token complet reçu : #{full_token}"
        token = full_token.gsub('Bearer ', '')
        puts "Token extrait : #{token}"
        user = User.find_by(authentication_token: token)
        puts "Utilisateur trouvé : #{user&.email}"
        if user
          sign_in user, store: false
          puts "Utilisateur connecté avec succès"
        else
          puts "Aucun utilisateur trouvé pour ce token"
          render json: { error: "Token non valide" }, status: :unauthorized
        end
    end

    def sign_up_params
        params.require(:user).permit(:name, :age, :level, :bio, :email, :password, :image)
    end
end

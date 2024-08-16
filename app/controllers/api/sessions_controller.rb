class Api::SessionsController < Devise::SessionsController
    skip_before_action :verify_signed_out_user, only: [:destroy]
    before_action :authenticate_user_from_token!, only: [:destroy]

    def create
        puts "In create session"
        self.resource = warden.authenticate!(auth_options)
        sign_in(resource_name, resource)
        token = resource.ensure_authentication_token
        render json: { message: 'Connexion réussie !', user: resource, authentication_token: token}
    end

    # def destroy
    #     puts "Current user: #{current_user}"
    #     sign_out(current_user)
    #     # if user_signed_in?
    #     #     sign_out(resource_name)
    #     #     render json: { message: 'Déconnexion réussie !' }, status: :ok
    #     # else
    #     #     render json: { error: 'Aucun utilisateur connecté.' }, status: :unprocessable_entity
    #     # end
    # end

    def destroy
        puts "Début de la déconnexion"
        if current_user
          puts "Utilisateur trouvé : #{current_user.email}"
          current_user.update(authentication_token: nil)
          sign_out current_user
          render json: { message: "Déconnexion réussie" }, status: :ok
        else
          puts "Aucun utilisateur connecté"
          render json: { error: "Aucun utilisateur connecté" }, status: :unauthorized
        end
    end

    private

    def authenticate_user_from_token!
        puts("je suis dans cette fonction")
        token = request.headers['Authorization']&.split(' ')&.last
        puts("j'ai le token du user", token)
        user = User.find_by(authentication_token: token)
        puts("j'ai le user en fonction du token", user)
        if user
            sign_in user, store: false
        else
            render json: { error: "Token non valide" }, status: :unauthorized
        end
    end
end

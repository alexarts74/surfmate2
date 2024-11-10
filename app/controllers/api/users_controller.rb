module Api
  class UsersController < ApplicationController
    before_action :authenticate_user_from_token!

    def index
      puts "Récupération de la liste des utilisateurs"
      @users = User.all
      render json: @users
    end

    def show
      @user = User.find(params[:id])
      render json: @user
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Utilisateur non trouvé" }, status: :not_found
    end

    def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        render json: @user
      else
        render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.require(:user).permit(:name, :bio, :age, :level)
    end
  end
end

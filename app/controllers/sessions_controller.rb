class SessionsController < ApplicationController
  # app/controllers/sessions_controller.rb
  # Afficher toutes les sessions de surf
  def index
    @sessions = Session.all
    render json: @sessions
  end

  # Afficher une session de surf spécifique
  def show
    @session = Session.find(params[:id])
    render json: @session
  end

  # Créer une nouvelle session de surf
  def create
    @session = Session.new(session_params)
    if @session.save
      render json: @session, status: :created
    else
      render json: @session.errors, status: :unprocessable_entity
    end
  end

  # Mettre à jour les informations d'une session de surf
  def update
    @session = Session.find(params[:id])
    if @session.update(session_params)
      render json: @session
    else
      render json: @session.errors, status: :unprocessable_entity
    end
  end

  # Supprimer une session de surf
  def destroy
    @session = Session.find(params[:id])
    @session.destroy
    head :no_content
  end

  private

  def session_params
    params.require(:session).permit(:location, :date, :description, :user_id)
  end
end

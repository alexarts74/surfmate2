class Api::SurfingSessionsController < ApplicationController
  # Afficher toutes les sessions de surf
  def index
    @surfing_sessions = SurfingSession.all
    render json: @surfing_sessions
  end

  # Afficher une session de surf spécifique
  def show
    @surfing_session = SurfingSession.find(params[:id])
    render json: @surfing_session
  end

  # Créer une nouvelle session de surf
  def create
    @surfing_session = SurfingSession.new(surfing_session_params)
    if @surfing_session.save
      render json: @surfing_session, status: :created
    else
      render json: @surfing_session.errors, status: :unprocessable_entity
    end
  end

  # Mettre à jour les informations d'une session de surf
  def update
    @surfing_session = SurfingSession.find(params[:id])
    if @surfing_session.update(surfing_session_params)
      render json: @surfing_session
    else
      render json: @surfing_session.errors, status: :unprocessable_entity
    end
  end

  # Supprimer une session de surf
  def destroy
    @surfing_session = SurfingSession.find(params[:id])
    @surfing_session.destroy
    head :no_content
  end

  private

  def surfing_session_params
    params.require(:surfing_session).permit(:location, :date, :description, :user_id)
  end
end

class MessagesController < ApplicationController
  # Afficher tous les messages
  def index
    @messages = Message.all
    render json: @messages
  end

  # Afficher un message spécifique
  def show
    @message = Message.find(params[:id])
    render json: @message
  end

  # Créer un nouveau message
  def create
    @message = Message.new(message_params)
    if @message.save
      render json: @message, status: :created
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # Mettre à jour les informations d'un message
  def update
    @message = Message.find(params[:id])
    if @message.update(message_params)
      render json: @message, status: :updated
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # Supprimer un message
  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    head :no_content
  end

  private

  def message_params
    params.require(:message).permit(:content, :sender_id, :recipient_id)
  end
end

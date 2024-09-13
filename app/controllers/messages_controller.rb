class MessagesController < ApplicationController
  include MessagesHelper
  before_action :set_chat, only: [:create]
  before_action :set_message, only: [:delete_for_me]

  def create
    @message = @chat.messages.new(message_params)
    @message.user = current_user
    if @message.save
      ChatChannel.broadcast_to(
        @chat,
        message: render_to_string(partial: "messages/message"),
        locals: { message: @message },
        sender_id: @message.user.id
      )
      head :ok
    else
      render json: { errors: @message.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def delete_for_me
    if @message
      @message.mark_deleted_for(current_user)
      render json: { success: true }
    else
      render json: { success: false, error: 'Message not found' }, status: :not_found
    end
  end

  private

  def set_chat
    @chat = Chat.find_by(id: params[:chat_id])
    unless @chat
      Rails.logger.error "Chat not found with id: #{params[:chat_id]}"
      render json: { error: 'Chat not found' }, status: :not_found
    end
  end

  def set_message
    @message = Message.find_by(id: params[:chat_id])
    unless @message
      Rails.logger.error "Message not found with id: #{params[:id]} in chat: #{@chat.id}"
      render json: { error: 'Message not found' }, status: :not_found
    end
  end

  def message_params
    params.require(:message).permit(:content)
  end
end

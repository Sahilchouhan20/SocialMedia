class MessagesController < ApplicationController
  before_action :set_message
  def create
    @chat = Chat.find(params[:chat_id])
    if @chat
      @message = @chat.messages.new(message_params)
      @message.user = current_user
      @message.save
      # Broadcast the message to all subscribers
      ChatChannel.broadcast_to(
        @chat,
        message: render_to_string(partial: "messages/message"),
        locals: { message: @message },
        sender_id: @message.user.id
      )
      head :ok
    end
  end

  def delete_for_everyone
    if @message && @message.user == current_user
      @message.update(deleted_for_everyone: true)
      ChatChannel.broadcast_to(
        @message.chat,
        action: 'delete_message',
        message_id: @message.id
      )
      render json: { success: true }
    else
      render json: { success: false, error: 'Unauthorized or message not found' }, status: :unauthorized
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def set_message
    @message = Message.find_by(id: params[:id])
  end
end

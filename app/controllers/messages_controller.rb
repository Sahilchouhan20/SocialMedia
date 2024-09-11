class MessagesController < ApplicationController
  before_action :set_message, only: [:destroy, :delete_for_me]

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

  def destroy
    if @message.user == current_user
      @message.destroy
      ChatChannel.broadcast_to(
        @message.chat,
        action: 'delete_message',
        message_id: @message.id
      )
      render json: { success: true }, status: :ok
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def delete_for_me
    current_user.deleted_messages << @message unless current_user.deleted_messages.include?(@message)
    render json: { success: true }, status: :ok
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def set_message
    @message = Message.find(params[:id])
  end
end

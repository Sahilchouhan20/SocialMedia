class ChatChannel < ApplicationCable::Channel
  def subscribed
    # Find the chat based on the chat_id parameter
    chat = Chat.find(params[:id])
    # Stream for the found chat
    stream_for chat
  rescue ActiveRecord::RecordNotFound
    # If the chat is not found, reject the subscription
    reject
  end

  # Define the unsubscribed method, I'll leave that up to you :)
  def unsubscribed
  end
end

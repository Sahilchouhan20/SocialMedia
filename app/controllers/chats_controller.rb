class ChatsController < ApplicationController
  def show
    @user = current_user
    @chats = @user.chats
    #Search for a chat if it exists or create a new instance of chat↓
    @chat = find_or_create_chat
    @messages = @chat.messages
    @message = Message.new
    @message.user = current_user
    #user 1 is the current user, now we need to find the other user
    @other_user = User.find(@other_user_id) if @other_user_id #the if here makes sure the app doesnt break if the other user doesnt exist
  end
private
  def find_or_create_chat
    # Get the current user's ID
    @user_id = current_user.id.to_i

    # Check if another user ID is provided in the params
    @other_user_id = params[:other_user_id].to_i if params[:other_user_id].present?

    # Find the other user based on the ID (if available)
    @other_user = User.find(@other_user_id) if @other_user_id

    # If another user ID is present
    if @other_user_id
      # Find an existing chat where both users are participants
      chat = Chat.joins(:chat_users)
        .where(chats: { name: generate_chat_name(@user_id, @other_user_id) })
        .where(chat_users: { user_id: [@user_id, @other_user_id] })
        .group('chats.id')
        .having('COUNT(DISTINCT chat_users.user_id) = 2').first

      # If no existing chat is found, create a new chat
      chat ||= Chat.create(name: generate_chat_name(@user_id, @other_user_id))

      # Create chat users for both participants
      create_chat_user(chat, @user_id)
      create_chat_user(chat, @other_user_id)
    else
      # If no other user ID is provided, find the chat based on the provided chat ID
      chat = Chat.find_by(id:params[:id])
    end

    # Return the chat (either existing or newly created)
    chat
 end

  # Define a method to generate a unique chat name based on user IDs
  def generate_chat_name(user_id, other_user_id)
    [user_id, other_user_id].sort.join('&')
  end

  # Define a method to create a chat user record for a given user in a chat
  def create_chat_user(chat, user_id)
    # Find or create a chat user record with the specified user ID
    chat.chat_users.find_or_create_by(user_id: user_id)
  end
end

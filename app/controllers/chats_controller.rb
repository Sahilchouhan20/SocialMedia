class ChatsController < ApplicationController
  def start_chat
    @user = current_user
    @other_user = User.find(params[:other_user_id])
    @chat = find_or_create_chat
    redirect_to @chat
  end

  def show
    @user = current_user
    @chats = @user.chats
    @chat = find_or_create_chat
    @messages = @chat.messages.visible_to(current_user).includes(:user)
    @message = Message.new
    @message.user = current_user
    @other_user = User.find(@other_user_id) if @other_user_id
  end

  private

  def find_or_create_chat
    @user_id = current_user.id.to_i
    @other_user_id = params[:other_user_id].to_i if params[:other_user_id].present?
    @other_user = User.find(@other_user_id) if @other_user_id
    if @other_user_id
      chat = Chat.joins(:chat_users)
        .where(chats: { name: generate_chat_name(@user_id, @other_user_id) })
        .where(chat_users: { user_id: [@user_id, @other_user_id] })
        .group('chats.id')
        .having('COUNT(DISTINCT chat_users.user_id) = 2').first
      chat ||= Chat.create(name: generate_chat_name(@user_id, @other_user_id))
      create_chat_user(chat, @user_id)
      create_chat_user(chat, @other_user_id)
    else
      chat = Chat.find_by(id:params[:id])
    end
    chat
  end

  def generate_chat_name(user_id, other_user_id)
    [user_id, other_user_id].sort.join('&')
  end

  def create_chat_user(chat, user_id)
    chat.chat_users.find_or_create_by(user_id: user_id)
  end
end

module MessagesHelper
  def visible_messages(messages, user)
    messages.reject do |message|
      message.deleted_for_everyone || message.deleted_for&.include?(user.id)
    end
  end
end

class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat

  has_and_belongs_to_many :users_deleted_for, class_name: 'User', join_table: 'messages_users_deleted_for'

  def visible_for?(user)
    users_deleted_for.exclude?(user)
  end
end

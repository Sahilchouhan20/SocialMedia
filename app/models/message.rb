class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat

  scope :visible_to, ->(user) {
    where.not(deleted_for_everyone: true)
      .where("deleted_for IS NULL OR NOT deleted_for @> ?", [user.id].to_json)
  }
end

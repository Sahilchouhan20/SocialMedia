class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat

  serialize :deleted_for, Array, coder: JSON

  scope :visible_to, ->(user) {
    where("deleted_for IS NULL OR deleted_for NOT LIKE ?", "%#{user.id}%")
  }

  def deleted_for?(user)
    deleted_for.include?(user.id)
  end

  def mark_deleted_for(user)
    self.deleted_for = (deleted_for || []) + [user.id]
    save
  end
end

class Story < ApplicationRecord
  has_many_attached :stories
  has_many :likes, as: :likeable
  belongs_to :user

  scope :active, -> { where('created_at > ?', 24.hours.ago) }

  def self.remove_expired
    where('created_at <= ?', 24.hours.ago).destroy_all
  end
end

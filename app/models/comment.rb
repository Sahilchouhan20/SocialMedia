class Comment < ApplicationRecord
  validates :post_id, :user_id, :discription, presence: true
  belongs_to :post
  belongs_to :user
  has_many :likes, as: :likeable
end

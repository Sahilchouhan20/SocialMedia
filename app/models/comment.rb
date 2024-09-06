class Comment < ApplicationRecord
  validates :post_id, :discription, presence: true
  belongs_to :post
  has_many :likes, as: :likeable
end

class Story < ApplicationRecord
  has_many_attached :stories
  has_many :likes, as: :likeable
  belongs_to :user
end

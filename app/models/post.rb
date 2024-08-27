class Post < ApplicationRecord
  has_many_attached :images, dependent: :destroy
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

end

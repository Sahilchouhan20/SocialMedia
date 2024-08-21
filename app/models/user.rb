class User < ApplicationRecord
  followability

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :likes
  has_many :posts
  has_many :stories
  has_one_attached :avatar

  def unfollow(user)
    followerable_relationships.where(followable_id: user.id).destroy_all
  end

end

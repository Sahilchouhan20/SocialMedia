class User < ApplicationRecord
  validates :name, :username, :bio, presence: true

  followability

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :likes, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :stories, dependent: :destroy
  has_one_attached :avatar, dependent: :destroy
  has_many :chat_users
  has_many :chats, through: :chat_users
  has_many :messages, dependent: :destroy

  def unfollow(user)
    followerable_relationships.where(followable_id: user.id).destroy_all
  end

end

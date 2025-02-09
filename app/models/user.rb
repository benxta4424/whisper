class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts
  has_many :comments

  # users that the current user being followed by
  has_many :follower_relationships, class_name: "Friendship", foreign_key: "follower_id"
  has_many :followers, through: :follower_relationships, source: :follower

  # users that are being followed by the current user
  has_many :followed_relationships, class_name: "Friendship", foreign_key: "followed_id"
  has_many :following, through: :followed_relationships, source: :followed
end

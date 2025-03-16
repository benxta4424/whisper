class ChatRoom < ApplicationRecord
  belongs_to :follower, class: "User"
  belongs_to :followed, class: "User"

  has_many :messages
end

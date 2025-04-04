class Message < ApplicationRecord
  belongs_to :chat_room
  belongs_to :user

  validates :content, length: { in: 1..500 }
end

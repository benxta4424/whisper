class Post < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  has_many :likes
  has_many :comments

  scope :ascending, -> { order(created_at: :desc) }
end

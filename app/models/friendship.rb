class Friendship < ApplicationRecord
  belongs_to :follower, class_name: "user"
  belongs_to :followed, class_name: "User"
end

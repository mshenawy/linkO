class Followingship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "Category"
  
  validates :following_id, presence: true
  validates :follower_id, presence: true

end

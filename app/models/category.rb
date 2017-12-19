class Category < ApplicationRecord
  mount_uploader :image, PictureUploader
  validates :image , presence: true
  has_many :links
  has_many :follower_relationships, foreign_key: :following_id, class_name: 'Follow'
  has_many :follower, through: :follower_relationships, source: :follower
  validates :name,  presence: true	
  validates :about,  presence: true	
 	
end

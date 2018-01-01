class Category < ApplicationRecord
	mount_uploader :image, PictureUploader
	has_many :links, dependent: :destroy
	has_many :follower_relationships, foreign_key: :following_id, class_name: 'Follow'
	has_many :follower, through: :follower_relationships, source: :follower
	validates :name,  presence: true, uniqueness: { case_sensitive: false }	
	validates :arabic_name, presence: true, uniqueness: { case_sensitive: false }
	validates :about,  presence: true	
	validates :image , presence: false
	belongs_to :user , required: true

end

class Link < ApplicationRecord
	validates :title,  presence: true
	validates :url,  presence: true
	acts_as_votable
	belongs_to :user
	has_many :comments
	belongs_to :category
	mount_uploader :image, PictureUploader
	validates :image , presence: false, allow_nil: true
end

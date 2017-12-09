class Link < ApplicationRecord
	validates :title,  presence: true, uniqueness: { case_sensitive: false }
	validates :url,  presence: true, :format => URI::regexp(%w(http https)),uniqueness: { case_sensitive: false }
	acts_as_votable
	belongs_to :user
	has_many :comments
	belongs_to :category
	mount_uploader :image, PictureUploader
	validates :image , presence: false, allow_nil: true
end

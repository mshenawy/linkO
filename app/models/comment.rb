class Comment < ActiveRecord::Base
  acts_as_votable
  belongs_to :user
  belongs_to :link
  validates :body,  presence: true
end

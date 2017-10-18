class Message < ApplicationRecord
	belongs_to :user
  	default_scope -> { order(created_at: :desc) }
  	validates :user_id, presence: true
  	validates :content, presence: true, allow_nil: false
  	validates :sender, presence: true, allow_nil: false

   	private

end

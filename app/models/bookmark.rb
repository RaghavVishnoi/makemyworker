class Bookmark < ActiveRecord::Base

	belongs_to :gig
	belongs_to :user

	validates :gig_id, presence: true
	validates :user_id, presence: true

end
class Credit < ActiveRecord::Base

	has_many :users

	validates :user_id, presence: true
	validates :counts, presence: true

end
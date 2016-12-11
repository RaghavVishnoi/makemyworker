class Review < ActiveRecord::Base

	has_many :requests
	has_many :users

	
	validates :rating, presence: true
	validates :user_id, presence: true
	validates :request_id, presence: true,uniqueness: true
	validate :description

	

end
class Issue < ActiveRecord::Base

	belongs_to :request
	belongs_to :user

	validates :request_id, presence: true
	validates :sender_id, presence: true
	validate :description

end
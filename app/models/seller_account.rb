class SellerAccount < ActiveRecord::Base

	before_save :default_values
	has_many :users

	validates :recipient_id, presence: true
	validates :status, presence: true 
	validates :user_id, presence: true 


	private
		def default_values
			self.status ||= 'Active'
		end

end
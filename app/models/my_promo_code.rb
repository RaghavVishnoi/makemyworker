class MyPromoCode < ActiveRecord::Base

	before_save :default_values

	belongs_to :user
	belongs_to :promo_code

	validates :promo_code_id, presence: true
	validates :user_id, presence: true
	validate  :added_on
	validate  :status
	validates :code, presence: true


private
	def default_values
		self.status ||= 0
		self.added_on ||= Time.now
	end

end
class PromoCode < ActiveRecord::Base

	belongs_to :user
	before_save :default_values

	validates :code, presence: true
	validates :amount, presence: true
	validate  :user_id
	validate  :status
	validates :amount_type, presence: true
	validate  :expire_on
	validate  :all_users

	private
	  def default_values
	  	self.status ||= 0
	  end

	 
end
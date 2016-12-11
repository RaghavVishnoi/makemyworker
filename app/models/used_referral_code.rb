class UsedReferralCode < ActiveRecord::Base

	before_save :default_values

	belongs_to :user
    belongs_to :referral_code

    validates :user_id, presence: true
    validates :referral_code_id, presence: true
    validate  :status


    private 
    	def default_values
    		self.status ||= 0
    	end

end
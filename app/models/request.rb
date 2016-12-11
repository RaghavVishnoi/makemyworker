class Request < ActiveRecord::Base

    before_save :default_values

	belongs_to :user
	belongs_to :gig
	has_many :reviews
	has_many :messages

	validates :gig_id,presence: true
	validates :seller_id,presence: true
	validates :buyer_id,presence: true
	validate :message_count
	validate :status

	private
	    def default_values
	      self.flagged ||= false
	      self.status ||= 1
	    end

	    

end

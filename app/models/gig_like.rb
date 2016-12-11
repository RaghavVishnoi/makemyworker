class GigLike < ActiveRecord::Base

    after_save :notify_seller
    after_save :recent_activity

	has_many :gigs
	has_many :users

	validates :gig_id, presence: true
	validates :user_id, presence: true

	def self.like_count(gig_id)
		GigLike.where(:gig_id => gig_id).length
	end

	def self.user_like(gig_id,user_id)
		GigLike.exists?(:gig_id => gig_id,:user_id => user_id)
	end

	private
	   def notify_seller
	   	  gig = Gig.find(gig_id)
	   	  message = "#{User.find(user_id).first_name} liked your offer, #{gig.title}"
	   	  Notifications.notification(gig.user_id,message,'recentActivity')
	   end

	   def recent_activity
	   	  gig = Gig.find(gig_id)
	   	  message = "#{User.find(user_id).first_name} liked your offer, #{gig.title}"
	   	  RecentActivity.create(user_id: gig.user_id,message: message,sender_id: user_id)	   	  
	   end

end
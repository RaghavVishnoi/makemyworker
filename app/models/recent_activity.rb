class RecentActivity < ActiveRecord::Base


	has_many :users

	def self.recent_activity_data(user_id)
		@activities = []
		self.where(user_id: user_id).each do |activity|
			 @activity = {}
			 if activity.sender_id != 0 && activity.sender_id != nil
			 	@user = User.find(activity.sender_id)
			 	@activity[:profile_picture] = @user.photo_url
			 else
			 	@activity[:profile_picture] = ''
			 end			 
			 @activity[:id] = activity.id
			 @activity[:message] = activity.message
			 @activity[:created_at] = activity.created_at.strftime("%FT%H:%M:%S.%LZ")
			 @activities.push(@activity)
		end
		@activities
	end

end

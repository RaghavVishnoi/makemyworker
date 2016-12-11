class Api::V1::RecentActivitiesController < Api::V1::ApisController

	def index
		@recent_activities = RecentActivity.recent_activity_data(User.get_user(token).id)
		render :json => {:result => true,:object => @recent_activities}
	end

end
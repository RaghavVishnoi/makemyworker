class HelpsController < ApplicationController

	def show
		@gig = find_gig
		@user = User.find(@gig.user_id)
		@category = Category.find(@gig.category_id)
	end

	def find_gig
		Gig.find_by(token: params[:token])
	end

end

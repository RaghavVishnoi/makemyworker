class Api::V1::VenuesController < Api::V1::ApisController
	skip_before_action :authenticate, only: [:create]

	def create
		@venue = Venue.new(venues_params.
			merge(token: Token.new.generate))
		if @venue.save
			render :json => {:result => true,:object => @venue}
		else
			render_errors @venue.errors.full_messages
		end
	end

	def venues_params
		params.require(:venue).permit(:name,:address,:main_picture_url,:thumbnail_picture_url,:location_id,:category_names,:lat,:lng,:status)
	end

end
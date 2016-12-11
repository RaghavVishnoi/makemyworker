class Api::V1::CitiesWantsController < Api::V1::ApisController


	def index
		@cities_wants = CitiesWant.all
		render :json => {:result => true,:object => @cities_wants}
	end

	def create
		@cities_want = CitiesWant.new(cities_want_params.
									merge(user_id: User.get_user(token).id)
								)
		if @cities_want.save
			render :json => {:result => true,:object => @cities_want}
		else
			render_errors @cities_want.errors.full_messages
		end
	end

	def cities_want_params
		params.require(:cities_want).permit(:name)
	end

end
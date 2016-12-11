class Api::V1::LocationsController < Api::V1::ApisController
	skip_before_action :authenticate, only: [:search]

	def search
		locations = Map.search(params[:lat],params[:lng],params[:radius])
		gig = Location.gigs(locations)
		render :json => {:result => true, :object => locations}		
	end
end


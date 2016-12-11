class Api::V1::NeighborhoodsController < Api::V1::ApisController
	include NeighborhoodHelper
	skip_before_action :authenticate, only: [:index,:create,:show]

	def index
		@neighborhoods = Neighborhood.all.order('name asc')
		render :json => {:result => true,:object => @neighborhoods}
	end

	def filter
		@neighborhoods = filter_neighborhood(params[:lat],params[:lng],params[:neighborhood_ids],token)
		render :json => {:result => true,:object => @neighborhoods}
	end

	def show
		@neighborhood = Neighborhood.find(params[:id])
		if @neighborhood.entire_city == 'false'
		   render :json => {:result => true,:object => @neighborhood}
		else
			@neighborhoods = Neighborhood.where(:city_id => @neighborhood.city_id)
			render :json => {:result => true,:object => @neighborhoods}
		end
	end

end
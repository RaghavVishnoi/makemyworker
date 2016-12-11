class Api::V1::CitiesController < Api::V1::ApisController
	skip_before_action :authenticate, only: [:index,:create,:show]
	def index
		@cities = City.all
		render :json => {:result => true,:object => @cities}
	end

	def show
		@city = City.find_city(params[:id],params[:lat],params[:lng],token,params[:category_id],params[:featured])
		render :json => {:result => true,:object => @city}		
	end

	def neighborhoods
		city = City.find(params[:id])
		neighborhood = Neighborhood.find_by(:city_id => city.id)
		neighborhoods = city.neighborhoods.where('id NOT IN (?)',neighborhood.id)
		neighborhoods.push(neighborhood).sort!
		render :json => {:result => true,:object => neighborhoods}
	end
end
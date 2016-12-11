class Api::V1::CategoriesController < Api::V1::ApisController

	def index
		@categories = Category.all.order('id asc')
		render :json => {:result => true,:object => @categories}
	end	

end
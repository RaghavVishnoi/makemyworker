class Api::V1::ReviewsController < Api::V1::ApisController

	def index
		@reviews = Review.where(user_id: User.get_user(token).id)
		render :json => {:result => true,:object => @reviews}
	end


	def create
		@review = Review.new(review_params.
							merge(user_id: User.get_user(token).id)
						)	
		if @review.save
			render :json => {:result => true,:object => @review}
		else
			render_errors @review.errors.full_messages
		end
	end

	def show
		@review = find_review
		render :json => {:result => true,:object => @review}
	end

	def review_params
		params.require(:review).permit(:rating,:description,:request_id)
	end

	def find_review
		Review.find_by(request_id: params[:id])
	end

end
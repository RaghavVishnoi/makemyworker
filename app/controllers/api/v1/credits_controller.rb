class Api::V1::CreditsController < Api::V1::ApisController

	def index
		@credits = Credit.find_by(user_id: params[:user_id])
		render :json => {:result => true,:object => @credits}
	end

	def credit_params
		params.require(:credit).permit(:counts)
	end

end
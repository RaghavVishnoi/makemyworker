class Api::V1::ChargesController < Api::V1::ApisController

	def index
		@charges = Charge.where(user_id: params[:id])
		render :json => {:result => true,:object => @charges}
	end

end
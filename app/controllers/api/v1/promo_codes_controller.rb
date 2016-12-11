class Api::V1::PromoCodesController < Api::V1::ApisController

	def create
		@promo_code = PromoCode.new promo_code_params
		if @promo_code.save
			render :json => {:result => true,:object => @promo_code}
		else
			render_errors @promo_code.errors.full_messages
		end
	end


	def promo_code_params
		params.require(:promo_code).permit(:code,:user_id,:amount,:amount_type,:all_users,:expire_on)
	end

end
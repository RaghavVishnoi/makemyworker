class Api::V1::ReferralCodesController < Api::V1::ApisController

	def show
		@referral_code = ReferralCode.find_by(user_id: User.get_user(token).id).code
		render :json => {:result => true,:object => @referral_code}
	end
	
end
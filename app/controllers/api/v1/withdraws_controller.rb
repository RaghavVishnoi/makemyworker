class Api::V1::WithdrawsController < Api::V1::ApisController

	def index
		@withdraws = Withdraw.where(user_id: User.get_user(token).id)
		render :json => {:result => true,:object => @withdraws}
	end

	def create
		user = User.get_user(token)
		user_account = SellerAccount.find_by(user_id: user.id)
		withdraw = Withdraws.transfer(user.id,withdraw_params[:amount])
		if withdraw != 0 && withdraw != 2			
			render :json => {:result => true,:message => t('stripe.withdraw.success')}
		else
			render :json => {:result => false,:errors => STRIPE_ERROR[withdraw]}
		end	
        
	end

    def withdraw_params
    	params.require(:withdraw).permit(:amount)
    end

    

end
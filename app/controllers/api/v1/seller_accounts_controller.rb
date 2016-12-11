class Api::V1::SellerAccountsController < Api::V1::ApisController

	def index
		@seller_accounts = SellerAccount.where(status: 'Active')
		render :json => {:result => true,:object => @seller_accounts}
	end

	def create
		user = User.get_user(token)
		if SellerAccount.exists?(user_id: user.id)
			@seller_account = SellerAccount.find_by(user_id: user.id)	
			@seller_account.update(recipient_id: StripeRecipient.generate(seller_account_params[:recipient_id],user.first_name,user.last_name))
			if @seller_account != nil
				recipient = StripeRecipient.retrieve(@seller_account.recipient_id)	
				render :json => {:result => true,:object => recipient}
			else
				nil
			end
		else
			@seller_account = SellerAccount.new(recipient_id: StripeRecipient.generate(seller_account_params[:recipient_id],user.first_name,user.last_name),
									user_id: User.get_user(token).id)			
								
			if @seller_account.save!
			    recipient = StripeRecipient.retrieve(@seller_account.recipient_id)	
				render :json => {:result => true,:object => recipient}
			else
				render_errors @seller_account.errors.full_messages
			end
		end	
	end

	def show
		@seller_account = find_seller_account
		render :json => {:result => true,:object => @seller_account}
	end

	def seller_account_params
		params.require(:seller_account).permit(:token,:recipient_id)
	end

	def find_seller_account
		seller_account = SellerAccount.find_by(id: params[:id],status: 'Active')
		if seller_account != nil
			StripeRecipient.retrieve(seller_account.recipient_id)
		else
			nil
		end	
	end


end
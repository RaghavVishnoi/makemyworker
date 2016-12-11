class Api::V1::BuyerAccountsController < Api::V1::ApisController


	def index
		@buyer_accounts = BuyerAccount.where(status: 'Active')
		render :json => {:result => true,:object => @buyer_accounts}
	end

	def create
		@buyer_account = BuyerAccount.new(customer_id: StripeCustomer.generate(User.get_user(token).email,buyer_account_params[:token]),
								user_id: User.get_user(token).id)			
		if BuyerAccount.exists?(user_id: User.get_user(token).id)	
		    buyer_account = BuyerAccount.find_by(user_id: User.get_user(token).id)					
			render :json => {:result => true,:object => StripeCustomer.retrieve(buyer_account.customer_id)}
		else
			if @buyer_account.save
				customer = StripeCustomer.retrieve(@buyer_account.customer_id)
				render :json => {:result => true,:object => customer}
			else
				render_errors @buyer_account.errors.full_messages
			end
		end	
	end

	def show
		@buyer_account = find_buyer_account
		if @buyer_account != nil
			render :json => {:result => true,:object => @buyer_account}
		else
			render :json => {:result => true,:object => {}}
		end
	end

	def buyer_account_params
		params.require(:buyer_account).permit(:token)
	end

	def find_buyer_account
		token = BuyerAccount.find_by(user_id: params[:id],status: 'Active').customer_id
		StripeCustomer.retrieve(token)
	end



end
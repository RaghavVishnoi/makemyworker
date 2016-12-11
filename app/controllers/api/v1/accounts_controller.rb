class Api::V1::AccountsController < Api::V1::ApisController

	def index
		@accounts = Account.accounts(User.get_user(token).id)
		render :json => {:result => true,:object => @accounts}
	end

end
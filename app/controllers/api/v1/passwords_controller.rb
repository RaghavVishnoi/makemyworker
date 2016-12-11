class Api::V1::PasswordsController < Api::V1::ApisController
    
    skip_before_action :authenticate
	def create
		if User.exists?(email: params[:email])
			if user = ClearanceAuth.find_user_for_create(params[:email])
				user.forgot_password!
				ClearanceAuth.deliver_email(user)
				render :json => {:result => true,:message => t('password.create.success')}	
	        end
	    else
	       render :json => {:error => t('password.create.error')}
	    end    
	end
end
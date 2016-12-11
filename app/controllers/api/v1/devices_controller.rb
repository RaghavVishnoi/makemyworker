class Api::V1::DevicesController < Api::V1::ApisController

	def create
		if Device.exists?(:user_id => find_user.id)
			@device = Device.find_by(:user_id => find_user.id)
			@device.update(:installation_id => device_params[:installation_id])
			render :json => {:result => true,:object => @device}
		else
			@device = Device.new(device_params.
						merge(user_id: find_user.id)
						)
			if @device.save
			    render :json => {:result => true,:object => @device}
			else
				render_errors @device.errors.full_messages
			end
		end
	end

	def update
		@device = Device.where(user_id: User.get_user(token).id)
	    @device.update_all(device_params)
	    render :json => {result: true}
	end


	def device_params
		params.require(:device).permit(:installation_id,:device_type)
	end

	def find_user
		User.get_user(token)
	end

end
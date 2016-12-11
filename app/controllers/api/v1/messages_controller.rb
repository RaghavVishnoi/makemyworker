class Api::V1::MessagesController < Api::V1::ApisController

	def index
		messages = Message.where(:request_id => params[:id])
		@messages = []
		messages.each do |message|
			Message.update_seen(message,find_user)
			@messages.push(Message.message_data(message.id))
		end
		render :json => {:result => true,:object => @messages}
	end

	def create	
		message = Message.new(message_params.
					merge(request_id: params[:id]).
					merge(user_id: find_user).
					merge(user_type: user_type(params[:id])).
					merge(seen: 0)
			        )
		if message.save
			@message = Message.message_data(message.id)
			render :json => {:result => true,:object => @message}
		else
			render_errors @message.errors.full_messages
		end
	end

	def message_params
		params.require(:message).permit(:content,:message_type)
	end

	def find_user
		User.get_user(token).id
	end

	def user_type(id)
		request = Request.find(id)
		if find_user == request.buyer_id
			'buyer'
		else
			'seller'
		end	

	end

end
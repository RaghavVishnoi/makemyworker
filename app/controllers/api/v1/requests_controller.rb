
class Api::V1::RequestsController < Api::V1::ApisController
	require "time_difference"
	include  RequestHelper
	
	def index	
 		@requests = requests.sort{|r1,r2| r1[:updated_at] <=> r2[:updated_at]}
		render :json => {:result => true,:object => @requests}
	end

	def create
		if is_exist(request_params[:buyer_id],request_params[:gig_id]) == false
			request = Request.new(
				request_params.
				merge(seller_id: find_seller)
				)
			if request.save
				if params[:message] != nil && params[:message] != '' 
					message = Message.new(:content => params[:message],:request_id => request.id,:user_id => request.buyer_id,:message_type => 1,:user_type => 'buyer',:seen => 0).save 
	            else
	            	request.update(status: 2)	
				end
				notifications(request,'createRequest')
				create_messages(request)
				@request = request_data(request,User.get_user(token).id)
				render :json => {:result => true,:object => @request}
			else
				render_errors request.errors.full_messages
			end
		else
		   request = Request.where(gig_id: request_params[:gig_id],buyer_id: request_params[:buyer_id]).last
		   if params[:message] != nil
					message = Message.new(:content => params[:message],:request_id => request.id,:user_id => request.buyer_id,:message_type => 1).save 
		   end
		   @request = request_data(request,User.get_user(token).id)
		   render :json => {:result => true,:object => @request}
		end	
	end

	def show
		request = find_request
		@request = request_data(request,User.get_user(token).id)
		request.update(seen: 1) if request.seller_id == User.find_by(token: token).id
		render :json => {:result => true,:object => @request}
	end

	def update
		request = find_request
		if request.status < params[:request][:status].to_i
		  request.update(:status => params[:request][:status])
		  create_messages(request)
		  @request = request_data(request,User.get_user(token).id)
			if request.status == 7
				charges = Charges.transaction(request)
				recent_activity(request.id)
				notifications(request,'recentActivity')
				if charges == true
					render :json => {:result => t('stripe.charge.response'),:status => request.status}
			    else
			    	render :json => {:result => false,:message => charges}
			    end
			elsif request.status == 6 && TimeDifference.between(request.created_at,Time.now).in_minutes > 5
				charges = Charges.transaction(request)
				notifications(request,'requestDetail')
				render :json => {:result => true,:object => charges}
			else
			   	notifications(request,'requestDetail')		
			    render :json => {:result => true,:object => @request}
		    end
	    else
	      render :json => {:result => true,:message => t('request.update.status.exception') }	
	    end
	end

	def request_params
		params.require(:request).permit(:gig_id,:buyer_id,:seller_id,:status,:flagged,:message_count)
	end

	def incomming
		@requests = []
		requests = Request.where(:seller_id => User.get_user(token).id).each do |request|
			@requests.push(incoming_request(request,User.get_user(token).id))
		end
		@requests
		render :json => {:result => true,:object => @requests}
	end

	def outgoing
		@requests = []
		requests = Request.where(:buyer_id => User.get_user(token).id).each do |request|
			@requests.push(outgoing_request(request,User.get_user(token).id))
		end
		@requests
		render :json => {:result => true,:object => @requests}
	end

	def find_request
		Request.find(params[:id])
	end

	def find_seller
		Gig.find(request_params[:gig_id]).user_id
	end

	private
		def requests
			@requests = []
			requests = Request.where(:seller_id => User.get_user(token).id).each do |request|
				@requests.push(merge_request(request,User.get_user(token).id,INCOMING))
			end
			requests = Request.where(:buyer_id => User.get_user(token).id).each do |request|
				@requests.push(merge_request(request,User.get_user(token).id,OUTGOING))
			end
			@requests
		end

end
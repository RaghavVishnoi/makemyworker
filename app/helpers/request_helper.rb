module RequestHelper

 def is_exist(user_id,gig_id)
 	if Request.where("gig_id = ? AND buyer_id = ? AND status NOT IN (?)",gig_id,user_id,[3,5,6,7]).blank?
 		false
    else
    	true
 	end
 end


 def request_data(request,current_user_id)
 	@request = {}
 	@seller = {}
 	@buyer = {}
    @messages = {}
 	gig = Gig.find(request.gig_id)
 	seller = User.find(request.seller_id)
 	buyer = User.find(request.buyer_id)
 	@request[:id] = request.id
 	@request[:status] = request.status
    @request[:gig_id] = gig.id
 	@request[:gig_title] = gig.title
 	@request[:gig_price] = gig.price
    @seller[:id] = seller.id
 	@seller[:seller_name] = seller.first_name
 	@seller[:seller_profile_picture] = seller.photo_url
 	@request[:messages] = message_data(request.id,request.seller_id,current_user_id)
 	@buyer[:id] = buyer.id
    @buyer[:buyer_name] = buyer.first_name
 	@buyer[:buyer_profile_picture] = buyer.photo_url
    @request[:seller] = @seller
    @request[:buyer] = @buyer
 	@request[:flagged] = request.flagged
    @request[:seen] = request.seen
 	@request[:message_count] = request.message_count
 	@request[:created_at] = request.created_at.strftime(t('request.request_data.date_format'))
    @request[:updated_at] = request.updated_at.strftime(t('request.request_data.date_format'))
 	@request
 end

 def incoming_request(request,current_user_id)
    @request = {}
    @buyer = {}
    buyer_messages = []
    gig = Gig.find(request.gig_id)
    buyer = find_user(request.buyer_id)
    @request[:id] = request.id
    @request[:status] = request.status
    @request[:gig_title] = gig.title
    @request[:gig_price] = gig.price
    @request[:seller] = ''
    @buyer[:buyer_name] = buyer.first_name
    @buyer[:buyer_profile_picture] = buyer.photo_url
    @buyer[:messages] = lattest_message(request.id,request.buyer_id,current_user_id)
    @request[:buyer] = @buyer # TO BE DEPRECATED on next release of the app
    @request[:flagged] = request.flagged
    @request[:seen] = request.seen
    @request[:message_count] = request.message_count
    @request[:created_at] = request.created_at.strftime t('request.outgoing.date_format')
    @request[:updated_at] = request.updated_at.strftime t('request.outgoing.date_format')
    @request[:type] = INCOMING
    @request
 end

 def outgoing_request(request,current_user_id)
    @request = {}
    @seller = {}
    seller_messages = []
    gig = Gig.find(request.gig_id)
    seller = find_user(request.seller_id)
    @request[:id] = request.id
    @request[:status] = request.status
    @request[:gig_title] = gig.title
    @request[:gig_price] = gig.price
    @seller[:seller_name] = seller.first_name
    @seller[:seller_profile_picture] = seller.photo_url
    @seller[:messages] = lattest_message(request.id,request.buyer_id,current_user_id)
    @request[:buyer] = ''
    @request[:seller] = @seller # TO BE DEPRECATED on next release of the app
    @request[:flagged] = request.flagged
    @request[:seen] = 1
    @request[:message_count] = request.message_count
    @request[:created_at] = request.created_at.strftime t('request.outgoing.date_format')
    @request[:updated_at] = request.updated_at.strftime t('request.outgoing.date_format')
    @request[:type] = OUTGOING
    @request
 end

 def merge_request(request,current_user_id,type)
    @request = {}
    @user = {}
    seller_messages = []
    gig = Gig.find(request.gig_id)
    user = if type == OUTGOING then find_user(request.seller_id) else find_user(request.buyer_id) end
    @request[:id] = request.id
    @request[:status] = request.status
    @request[:gig_title] = gig.title
    @request[:gig_price] = gig.price
    @user[:user_name] = user.first_name
    @user[:user_profile_picture] = user.photo_url
    @user[:messages] = lattest_message(request.id,if type == OUTGOING then request.buyer_id else request.seller_id end,current_user_id)
    @request[:buyer] = ''
    @request[:user] = @user # TO BE DEPRECATED on next release of the app
    @request[:flagged] = request.flagged
    @request[:seen] = 1
    @request[:message_count] = request.message_count
    @request[:created_at] = request.created_at.strftime t('request.outgoing.date_format')
    @request[:updated_at] = request.updated_at.strftime t('request.outgoing.date_format')
    @request[:type] = type
    @request
 end

 def message_data(request_id,user_id,current_user_id)
 	 messages = Message.where(:request_id => request_id).order('id desc')
     @messages = []
     messages.each do |message|
        Message.update_seen(message,current_user_id)
     	message_data = {}
     	message_data[:id] = message.id
     	message_data[:request_id] = request_id
     	message_data[:user_id] = message.user_id
     	message_data[:content] = message.content
        message_data[:seen] = message_seen(message,current_user_id)
     	message_data[:message_type] = message.message_type
     	message_data[:created_at] = message.created_at.strftime(t('request.outgoing.date_format'))
     	message_data[:updated_at] = message.updated_at.strftime(t('request.outgoing.date_format'))
     	if message.deleted_at != nil
            message_data[:deleted_at] = message.deleted_at.strftime(t('request.message_data.date_format'))
     	end
        @messages.push(message_data)
     end
     @messages
 end

 def lattest_message(request_id,user_id,current_user_id)
     message = Message.where(:request_id => request_id).last
     if message != nil
         #Message.update_seen(message,user_id)
         message_data = {}
         message_data[:id] = message.id
         message_data[:request_id] = request_id
         message_data[:user_id] = user_id
         message_data[:content] = message.content
         message_data[:seen] = message_seen(message,current_user_id)
         message_data[:message_type] = message.message_type
         message_data[:created_at] = message.created_at.strftime(t('request.outgoing.date_format'))
         message_data[:updated_at] = message.updated_at.strftime(t('request.outgoing.date_format'))
         if message.deleted_at != nil
            message_data[:deleted_at] = message.deleted_at.strftime(t('request.message_data.date_format'))
         end
         message_data
     else
        '{}'
    end
 end

 def create_messages(request)
    buyer = find_user(request.buyer_id)
    seller = find_user(request.seller_id)
    buyer_name = buyer.first_name
    seller_name = seller.first_name
    current_status = request.status
    case current_status
    when 1
        @message = user_message(Messages[0][0],buyer_name,seller_name)+" "+Messages[0][1]
    when 2
        @message = user_message(Messages[1][0],buyer_name,seller_name)+" "+Messages[1][1]
    when 3
        @message = user_message(Messages[2][0],buyer_name,seller_name)+" "+Messages[2][1]
    when 4
        @message = user_message(Messages[3][0],buyer_name,seller_name)+" "+Messages[3][1]
    when 5
        @message = user_message(Messages[4][0],buyer_name,seller_name)+" "+Messages[4][1]
    when 6
        @message = user_message(Messages[5][0],buyer_name,seller_name)+" "+Messages[5][1]
    when 7
        @message = user_message(Messages[6][0],buyer_name,seller_name)+" "+Messages[6][1]
    end
    Message.create(:content => @message,:message_type => 0,:user_id => buyer.id,:request_id => request.id,:user_type => 'buyer',:seen => 0)
 end

 def user_message(user,buyer_name,seller_name)
    if user == "buyer_name"
        buyer_name
    else
        seller_name
    end
 end

 def find_user(id)
    User.find(id)
 end

 def notifications(request,type)
    buyer = find_user(request.buyer_id)
    seller = find_user(request.seller_id)
    buyer_name = buyer.first_name
    seller_name = seller.first_name
    if request.status == 1
        message = user_message(Messages[0][0],buyer_name,seller_name)+" "+Messages[0][1]
        Notifications.notification(request.seller_id,message,type)
    elsif request.status == 2
        message = user_message(Messages[1][0],buyer_name,seller_name)+" "+Messages[1][1]
        Notifications.notification(request.seller_id,message,type)
    elsif request.status == 3
        message = user_message(Messages[2][0],buyer_name,seller_name)+" "+Messages[2][1]
        Notifications.notification(request.buyer_id,message,type)
    elsif request.status == 4
        message = user_message(Messages[3][0],buyer_name,seller_name)+" "+Messages[3][1]
        Notifications.notification(request.buyer_id,message,type)
    elsif request.status == 5
        message = user_message(Messages[4][0],buyer_name,seller_name)+" "+Messages[4][1]
        Notifications.notification(request.buyer_id,message,type)
    elsif request.status == 6
        message = user_message(Messages[5][0],buyer_name,seller_name)+" "+Messages[5][1]
        Notifications.notification(request.seller_id,message,type)
    elsif request.status == 7
        message = user_message(Messages[6][0],buyer_name,seller_name)+" "+Messages[6][1]
        Notifications.notification(request.buyer_id,message,type)
    end
 end

def recent_activity(request_id)
    request = Request.find(request_id)
    message = "#{User.find(request.seller_id).first_name} completed an offer for you"
    RecentActivity.create(user_id: request.buyer_id,message: message,sender_id: request.seller_id)
end

def message_seen(message,user_id)
    if message.user_id != user_id
        message.seen
    else
        1
    end
end


end

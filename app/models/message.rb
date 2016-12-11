class Message < ActiveRecord::Base

	after_save :notify_receiver

	belongs_to :request
	belongs_to :user

	validates :content, presence: true
	validates :request_id, presence: true
	validates :user_id, presence: true
	validates :message_type, presence: true
	validates	:seen, presence: true

	def self.update_seen(message,user_id)
		if message.seen != 1 && message.user_id != user_id
			message.update(seen: 1)
		end
	end

    def self.message_data(id)
	     message = Message.find(id)
	     message_data = {}
	     message_data[:id] = message.id
	     message_data[:request_id] = message.request_id
	     message_data[:user_id] = message.user_id
	     message_data[:content] = message.content
	     message_data[:message_type] = message.message_type
	     message_data[:seen] = message.seen
	     message_data[:created_at] = message.created_at.strftime("%FT%H:%M:%S.%LZ")
	     message_data[:updated_at] = message.updated_at.strftime("%FT%H:%M:%S.%LZ")
	     if message.deleted_at != nil
	     	message_data[:deleted_at] = message.deleted_at.strftime("%FT%H:%M:%S.%LZ")
	     end
	     message_data
    end

	def self.is_unseen_message(user_id)
		query_seller = "select * from messages
				left outer join requests on requests.id = messages.request_id
				where requests.seller_id = "+user_id.to_s+" AND messages.user_type = 'buyer' AND messages.seen = 0 AND
				messages.id IN (select id
					from (
					  select *, max(id) over (partition by request_id) as recent_message_id
					  from messages
					) as m
					where m.id = recent_message_id)"
		query_buyer = "select * from messages
				left outer join requests on requests.id = messages.request_id
				where requests.buyer_id = "+user_id.to_s+" AND messages.user_type = 'seller' AND messages.seen = 0 AND
				messages.id IN (select id
					from (
					  select *, max(id) over (partition by request_id) as recent_message_id
					  from messages
					) as m
					where m.id = recent_message_id)"

		is_unseen_as_seller = ActiveRecord::Base.connection.execute(query_seller).count != 0
		is_unseen_as_buyer = ActiveRecord::Base.connection.execute(query_buyer).count != 0

		return is_unseen_as_buyer || is_unseen_as_seller
	end

    private
    	def notify_receiver
    		if !content.include?(Messages[1][1]) && !content.include?(Messages[2][1]) && !content.include?(Messages[3][1]) && !content.include?(Messages[4][1]) &&  !content.include?(Messages[5][1]) && !content.include?(Messages[6][1])
	    		message = "#{sender_name} says: #{content}"
	    		Notifications.notification(find_notify_user,message,'requestDetail')
	    	end
    	end


    	def find_notify_user
			if user_type == "buyer"
				Request.find(request_id).seller_id
			else
				Request.find(request_id).buyer_id
			end
		end


		def find_user
			User.find(user_id)
		end

		def sender_name
			User.find(user_id).username
		end
end

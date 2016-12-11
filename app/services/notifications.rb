class Notifications

	def self.notification(user_id,message,mtype)
		if User.find(user_id).logged_in != false
			begin
				@data = {}
				alert = {}
				alert[:alert] = message
				type = {}
				type[:type] = mtype
				query = query(user_id)
				new_badge = update_badge(query)
				badge = {}
				badge[:badge] = new_badge
				sound = {}
				sound[:sound] = SOUND_FILE
				@data[:data] = alert.merge(type).merge(badge).merge(sound)
				@push = Parse::Push.new(@data[:data])
				@push.where = query.where 
				response = @push.save
				response
			rescue => e
				puts e.message
			end
		end	
	end

 	def self.query(user_id)
	    # initialize query object
		@query = Parse::Query.new(Parse::Protocol::CLASS_INSTALLATION)
		# set query where clause by some attribute
		@query.eq(INSTALLATION_ID, get_installation_id(user_id))
		# setting deviceType in where clause
		@query.eq(DEVICE_TYPE, get_device_type(user_id))		

		@query

    end

    def self.update_badge(query)
    	installation = query.get[0]
		badge = installation[BADGE].to_i
		new_badge = badge+1
		objectId = installation[OBJECT_ID]
		installation = Parse::Installation.new(objectId)
		installation.badge = new_badge
		installation.save
		new_badge
    end

    def self.get_installation_id(user_id)
    	device = Device.find_by(user_id: user_id)
    	if device != nil
    		device.installation_id
    	else
    		nil
    	end
    end

    def self.get_device_type(user_id)
    	device = Device.find_by(user_id: user_id)
    	if device != nil
    		device.device_type
    	else
    		nil
    	end
    end
end

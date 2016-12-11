module GigHelper

	def change_is_active(zone)
		user = User.where(:time_zone_name => zone).pluck(:id)
		if user.length != 0
			ids = Gig.where(:user_id => user).pluck(:id)
			if ids.length != 0
				ids.each do |id|
			    	Gig.where(:id => id).update_all(:is_active => false)
		        end
	        end
        end
	end

	
end
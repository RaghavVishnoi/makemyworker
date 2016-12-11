class Location

	def self.gigs(location)
		find_gig location
	end

	def self.find_gig(location)
		gigs = Gig.where("lat >= ? AND lat <= ? AND lng >= ? AND lng <= ?",location[:lat_min],location[:lat_max],location[:long_min],location[:long_max])
		gigs.each do |gig|
			@gig = {}
			user = User.find(gig.user_id)
			@gig[:id] = gig.id
			@gig[:title] = gig.title
			@gig[:description] = gig.description
			@gig[:price] = gig.price
			@gig[:category] = gig.category
			@gig[:user_id] = gig.user_id
			@gig[:venue_id] = gig.venue_id
			@gig[:lat] = gig.lat
			@gig[:lng] = gig.lng
			@gig[:radius] = gig.radius
			@gig[:is_active] = gig.is_active
			@gig[:friends_only] = gig.friends_only
			@gig[:token] = gig.token
			@gig[:sponsored] = gig.sponsored
			@gig[:status] = gig.status
			@gig[:username] = user.first_name+' '+user.last_name
			@gig[:bio] = user.bio
			@gig[:image] = user.photo_url
			@gig[:likes] = GigLike.like_count(gig.id)
		end
		@gig
	end

	def self.search(lat,lng,radius)
		locations = Map.search(lat,lng,radius)
		gig = Location.gigs(locations)
	end


end
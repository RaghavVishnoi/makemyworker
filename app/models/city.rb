class City < ActiveRecord::Base
	
	has_many :users
	has_many :neighborhoods

	def self.find_city(id,lat,long,token,category_id,featured)
		@city = City.find(id)
		@neighborhood = @city.neighborhoods
		gig_ids = []		
		neighborhood_ids = sort_neighborhood(lat,long,@neighborhood)
		if neighborhood_ids != nil && neighborhood_ids.length != 0
			neighborhood_ids.each do |neighborhood_id|
				if GigNeighborhoodAssociation.exists?(:neighborhood_id => neighborhood_id)
					GigNeighborhoodAssociation.where(:neighborhood_id => neighborhood_id).pluck(:gig_id).each do |id|
						if category_id != nil && category_id.length != 0
							gig = Gig.find(association.gig_id)
							if category_id.to_i == gig.category_id
								gig_ids.push(association.gig_id)
							end
						else
							gig_ids.push(association.gig_id)
						end						
				    end
				end
            end
		end
		user_gigs_id = User.gig(token)
		gig_ids = gig_ids - user_gigs_id
		if gig_ids != nil
			Gig.gig_data(gig_ids,token,featured)
		else
		
		end	
	end

	def self.sort_neighborhood(lat,long,neighborhoods)
		begin
			ndata = {}
			key = []
			neighborhoods.each do |neighborhood|
				ndata[neighborhood.id] = get_distance(lat,long,neighborhood.lat,neighborhood.lng)
			end
			ndata.sort_by {|_key, value| value}.each do |data|
				key.push(data[0])
			end
		key
		rescue

		end	
	end

	def self.get_distance(lat,long,nlat,nlong)
		Geocoder::Calculations.distance_between([lat,long],[nlat,nlong])
	end

	
end
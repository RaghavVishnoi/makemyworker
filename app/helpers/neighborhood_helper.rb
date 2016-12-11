module NeighborhoodHelper 
 
	def sort_neighborhood(lat,long,neighborhoods)
		ndata = {}
		key = []
		neighborhoods.each do |neighborhood|
			ndata[neighborhood.id] = get_distance(lat,long,neighborhood.lat,neighborhood.lng)
		end
		ndata.sort_by {|_key, value| value}.each do |data|
			key.push(data[0])
		end
		key	
	end

	def filter_neighborhood(lat,long,neighborhood_ids,token)
		if neighborhood_ids != nil
			@neighborhoods = []
			ndata = {}
			neighborhoods = Neighborhood.where(:id => neighborhood_ids.split(','))
			ids = sort_neighborhood(lat,long,neighborhoods)			
			gig_by_neighborhood(ids,token)
	    end
	end

	def gig_by_neighborhood(neighborhood_ids,token)
		  gig_ids = GigNeighborhoodAssociation.where(:neighborhood_id => neighborhood_ids).pluck(:gig_id)
		  user_gigs_id = User.gig(token)
		  gig_ids = gig_ids - user_gigs_id
		  Gig.gig_data(gig_ids,token)
	end

	def get_distance(lat,long,nlat,nlong)
		Geocoder::Calculations.distance_between([lat,long],[nlat,nlong])
	end

  end

class Map

	def self.search(lat,long,distance)
		center_point = [lat, long]
		box = Geocoder::Calculations.bounding_box(center_point, distance)
		locations = {}
		locations[:lat_min] = box[0]
		locations[:long_min] = box[1]
		locations[:lat_max] = box[2]
		locations[:long_max] = box[3]
		locations
	end

end
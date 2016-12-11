class Paging

	def self.pagination(object,page)
		if object != nil
			if object.length != 0
				object = object.flatten!.uniq
				start_index = page.to_i*PER_PAGE.to_i-PER_PAGE.to_i
				last_index = start_index+PER_PAGE.to_i-1
				object[start_index..last_index]
		    end
	    end
	end

end
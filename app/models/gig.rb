class Gig < ActiveRecord::Base

	attr_accessor :neighborhood_ids
	before_save :default_values

	belongs_to :user
	has_many :requests
 
	validates		  :title, presence: true
	validates		  :price, presence: true
	validates		  :user_id, presence: true
	validate		  :is_active
	validate          :category_id
	validate		  :token
	validate    	  :status
	validate          :featured


    def self.gig_neighborhood_association(neighborhood_ids,gig_id)
    	if neighborhood_ids != nil && neighborhood_ids.length != 0
	    	neighborhood_ids = neighborhood_ids.split(',')
	    	neighborhood_ids.each do |neighborhood_id|
	    		GigNeighborhoodAssociation.create(:gig_id => gig_id,:neighborhood_id => neighborhood_id)
	    	end
	    end
    end

    def self.gig_data(gig_ids,token,featured,query)
    	if gig_ids.kind_of?(Array)
    		@gig_ids = gig_ids
    	else
    		@gig_ids = gig_ids.split(',')
    	end
    	cities = []
    	if featured != nil
    		@gigs = Gig.where(id: gig_ids,featured: featured).order('updated_at desc')
    	else
    		@gigs = Gig.where(id: gig_ids).order('updated_at desc')
    	end
    	if query != nil
    		@query = query.downcase
    	else
    		@query = query
    	end
		@gigs.where('lower(title) LIKE ?',"%#{@query}%").each do |gig|
			if gig.status != 2
				cities.push(gig_details(gig,token))
			end
		end
			cities
    end

    def self.gig_details(gig,token)
    	user = User.get_user(token)
    	if gig != nil
			neighborhoods_id = neighborhoods_by_gig(gig.id)
			@gig = {}
			@user = gig.user
			@gig[:id] = gig.id
			@gig[:title] = gig.title
			@gig[:description] = gig.description
			@gig[:price] = gig.price
			@gig[:user_id] = gig.user_id
			@gig[:is_active] = gig.is_active
			@gig[:is_featured] = gig.featured
			@gig[:token] = gig.token
			@gig[:status] = gig.status.to_i
			@gig[:name] = @user.first_name+' '+@user.last_name
			@gig[:bio] = @user.bio
			@gig[:image] = @user.photo_url
			@gig[:likes] = GigLike.like_count(gig.id)
			@gig[:is_liked] = GigLike.user_like(gig.id,user.id).to_s
			neighborhood_name = []
			neighborhoods_id.each do |gig_neighborhood|
				neighborhood = Neighborhood.find(gig_neighborhood)
				if neighborhood.entire_city == true
					name = City.find(neighborhood.city_id).name
				    neighborhood_name.push("All of "+name)
				else
			        neighborhood_name.push(neighborhood.name)
		        end
		    end
			@gig[:neighborhoods_name] = neighborhood_name.sort_by{|word| word.downcase}
			@gig[:category] = gig_category(gig.category_id)
			@gig[:is_bookmarked] = check_bookmarked(user.id,gig.id)
			@gig
		end
    end

    def self.gig_info(gig,token)
    	user = User.get_user(token)
    	if gig != nil
			neighborhoods_id = neighborhoods_by_gig(gig.id)
			@gig = {}
			@user = gig.user
			@gig[:id] = gig.id
			@gig[:title] = gig.title
			@gig[:description] = gig.description
			@gig[:price] = gig.price
			@gig[:user_id] = gig.user_id
			@gig[:is_active] = gig.is_active
			@gig[:is_featured] = gig.featured
			@gig[:token] = gig.token
			@gig[:status] = gig.status.to_i
			@gig[:name] = @user.first_name+' '+@user.last_name
			@gig[:bio] = @user.bio
			@gig[:image] = @user.photo_url
			@gig[:likes] = GigLike.like_count(gig.id)
			@gig[:is_liked] = GigLike.user_like(gig.id,user.id).to_s
			neighborhood_name = []
			neighborhoods_id.each do |gig_neighborhood|
				neighborhood = Neighborhood.find(gig_neighborhood)
				if neighborhood.entire_city == true
					neighborhoods = Neighborhood.where(:city_id => neighborhood.city_id).pluck(:name)
				else
			        neighborhood_name.push(neighborhood.name)
		        end
		    end
			@gig[:neighborhoods_name] = neighborhood_name.sort_by{|word| word.downcase}
			@gig[:category] = gig_category(gig.category_id)
			gig_likes = []
			gig_likes(gig.id).each do |id|
				gig_like = {}
				like_user = User.find(id)
				gig_like[:username] = like_user.username
				gig_like[:profile_picture] = like_user.photo_url
				gig_likes.push(gig_like)
			end
			@gig[:likes_user] = gig_likes
			@gig[:reviews] = gig_reviews(gig.requests)
			@gig[:average_review] = average_review(gig.requests)
			@gig[:total_review] = total_review(gig.requests)
			@gig[:is_card_available] = is_card_available(user.id)
			@gig[:is_facebook_verified] = User.is_facebook_verified(@user.id)
			@gig[:bgcheck_approved] = @user.bgcheck_approved
			@gig
		end
    end

    def self.is_unseen_request(user_id)
			request = Request.find_by("seller_id = ? AND seen = ?",user_id,0)
    	if request != nil
    		true
    	else
    		false
    	end
    end

    def self.pending_review(user_id)
    	request_ids = buyer_requests(user_id)
    	reviews_request_ids = Review.where(user_id: user_id).pluck(:request_id)
    	@pending = request_ids - reviews_request_ids
    	pending_review = []
    	if @pending.length != 0
    		@pending.each do |pending|
    			result = {}
    			result[:result] = true
    			seller = {}
    			request = Request.find(pending)
    			@seller = User.find(request.seller_id)
    			seller[:request_id] = request.id
    			seller[:seller_id] = @seller.id
    			seller[:seller_name] = @seller.first_name
    			seller[:username] = @seller.username
    			seller[:profile_picture] = @seller.photo_url
    			seller[:request_date] = request.created_at.strftime("%b %d, %Y")
    			result[:seller] = seller
    			pending_review.push(result)
    		end
    		pending_review
    	else
    		result = {}
    		result[:result] = false
    		pending_review.push(result)
    		pending_review
    	end
    end

    def self.buyer_requests(user_id)
    	Request.where(buyer_id: user_id,status: 7).pluck(:id)
    end


    def self.neighborhoods_by_gig(id)
		GigNeighborhoodAssociation.where(:gig_id => id).pluck(:neighborhood_id)
	end

	def self.gig_likes(gig_id)
		GigLike.where(:gig_id => gig_id).pluck(:user_id)
	end

	def self.gig_category(id)
		Category.find(id).name
	end

	def self.gig_by_neighborhood(neighborhood_id,category_id)
		if GigNeighborhoodAssociation.exists?(:neighborhood_id => neighborhood_id)
			gig_ids = []
			GigNeighborhoodAssociation.where(:neighborhood_id => neighborhood_id).order('updated_at desc').each do |association|
				if category_id != nil && category_id.length != 0
					gig = Gig.find(association.gig_id)
					if category_id.to_i == gig.category_id
						gig_ids.push(association.gig_id)
					end
				else
					gig_ids.push(association.gig_id)
				end
			end
			gig_ids
		end
	end

	def self.gig_reviews(requests)
		@reviews = []
		requests.each do |request|
			reviews = request.reviews
			reviews.each do |review|
				if review.description != nil && review.description != " "
					hash = {}
					user = User.find(review.user_id)
					hash[:id] = review.id
					hash[:username] = user.username
					hash[:user_image] = user.photo_url
					hash[:rating] = review.rating
					hash[:description] = review.description
					hash[:created_at] = review.created_at.strftime("%FT%H:%M:%S.%LZ")
					@reviews.push(hash)
			    end
			end
		end
		@reviews
	end

	def self.average_review(requests)
		@reviews = []
		requests.each do |request|
			reviews = request.reviews
			@reviews.push(reviews.pluck(:rating)).flatten!
		end
		total = @reviews.length
		reviews_total = @reviews.inject(:+).to_f
		if reviews_total > 0
			reviews_total/total
		else
			0
		end
	end

	def self.total_review(requests)
		count = 0
		requests.each do |request|
			if Review.exists?(request_id: request.id)
				count = count+1
			end
		end
		count
	end

	def self.is_card_available(user_id)
		BuyerAccount.exists?(user_id: user_id)
	end

	def self.search(params,token)
		featured = params[:featured]
		query = params[:query]
		page = params[:page]
		if params.has_key?(:lat) && params.has_key?(:lng) && params.has_key?(:city) && params.has_key?(:hood)
			gigs = []
			neighborhood_ids = params[:hood]
			if neighborhood_ids != nil
			  @neighborhood_ids = City.sort_neighborhood(params[:lat],params[:lng],neighborhood_ids)
			  @neighborhood_ids = neighborhood_ids.split(',')
			  if @neighborhood_ids != nil && @neighborhood_ids.length != 0
			    @neighborhood_ids.each do |neighborhood_id|
			  	  gig_id = gig_by_neighborhood(neighborhood_id,params[:category_id])
		      	if gig_id != nil
	          	gigs.push(gig_id)
		        end
		      end
        end
      	@gigs = Paging.pagination(gigs,page)
        if page != nil
        	if @gigs != nil
        		gig_data(@gigs.flatten.uniq,token,featured,query)
          end
        else
        	gig_data(gigs.flatten.uniq,token,featured,query)
        end
			end
		elsif params.has_key?(:lat) && params.has_key?(:lng) && params.has_key?(:city)
	        gigs = []
	        city = City.find(params[:city])
	    neighborhood_ids = city.neighborhoods.pluck(:id)
	    @neighborhood_ids = City.sort_neighborhood(params[:lat],params[:lng],neighborhood_ids)
	    if neighborhood_ids != nil && neighborhood_ids.length != 0
				neighborhood_ids.each do |neighborhood_id|
					gig_id = gig_by_neighborhood(neighborhood_id,params[:category_id])
		    	if gig_id != nil
        		gigs.push(gig_id)
        	end
      	end
        @gigs = Paging.pagination(gigs,page)
        if page != nil
        	if @gigs != nil
        		gig_data(@gigs.flatten.uniq,token,featured,query)
          end
        else
        	gig_data(gigs.flatten.uniq,token,featured,query)
        end
      end
		elsif params.has_key?(:city) && params.has_key?(:hood)
    	gigs = []
    	neighborhood_ids = params[:hood].split(',')
    	if neighborhood_ids != nil && neighborhood_ids.length != 0
				neighborhood_ids.each do |neighborhood_id|
					gig_id = gig_by_neighborhood(neighborhood_id,params[:category_id])
		    	if gig_id != nil
		    		gigs.push(gig_id)
		    	end
		    end
        @gigs = Paging.pagination(gigs,page)
        if page != nil
        	if @gigs != nil
        		gig_data(@gigs.flatten.uniq,token,featured,query)
          end
        else
        	gig_data(gigs.flatten.uniq,token,featured,query)
        end
	    end
		elsif params.has_key?(:city)
			city = City.find(params[:city])
	    neighborhood_ids = city.neighborhoods.pluck(:id)
	    gigs = []
	    neighborhood_ids.each do |neighborhood_id|
	    	gig_id = gig_by_neighborhood(neighborhood_id,params[:category_id])
	    	if gig_id != nil
          gigs.push(gig_id)
	    	end
	    end
	    @gigs = Paging.pagination(gigs,page)
	    if page != nil
  	    if @gigs != nil
      		gig_data(@gigs.flatten.uniq,token,featured,query)
      	end
  		else
  			gig_data(gigs.flatten.uniq,token,featured,query)
    	end

		else
      @gigs = Paging.pagination(gigs,page)
      if page != nil
        if @gigs != nil
        	gig_data(@gigs.flatten.uniq,token,featured,query)
        end
  		else
    	Gig.gig_data(Gig.all.pluck(:id),token,featured,query)
    end
	end
end

	def self.bookmark_notification(token,id)
		user_id = User.get_user(token).id
		gig = Gig.find(id)
		seller = gig.user
		if Bookmark.exists?(user_id: user_id,gig_id: id)
			message = "#{seller.first_name}'s gig is now available : #{gig.title} "
			Notifications.notification(user_id,message)
		end
	end

	def self.check_bookmarked(user_id,gig_id)
		Bookmark.exists?(user_id: user_id, gig_id: gig_id)
	end


    private
	    def default_values
	      self.is_active ||= true
	      self.status ||= '1'
	      self.featured ||= 'false'
	    end


end

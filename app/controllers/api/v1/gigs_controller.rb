class Api::V1::GigsController < Api::V1::ApisController
	include GigHelper

	skip_before_action :authenticate, only: [:index,:create,:show,:is_active]

	def index
		if URI(request.url).path == api_user_gigs_path
			@gigs = Gig.where(user_id: params[:user_id])
			user = User.get_user(token)
      @likes = {}; @is_liked = {}; @category = {}; @is_bookmarked = {}
			@gigs.each do |gig|
				@likes[gig.id] = GigLike.like_count(gig.id)
        @is_liked[gig.id] = GigLike.user_like(gig.id,user.id).to_s
				@category[gig.id] = Category.find(gig.category_id).name
				@is_bookmarked[gig.id] = Bookmark.exists?(user_id: user, gig_id: gig.id)
			end
			render :index
    else
			@gigs = Gig.all
			render :json => {:result => true, :object => @gigs}
		end
	end

	def create
		@gig = Gig.new(gigs_params.
		       merge(token: GigToken.generate).
		       merge(user_id: User.get_user(token).id)
		       )

		if @gig.save
		 @gig_neighborhood = Gig.gig_neighborhood_association(params[:neighborhood_ids],@gig.id)
		 @gigs = Gig.gig_data(@gig.id.to_s,token,featured,query)
		 render :json => {:result => true, :object => @gigs}
		else
		 render_errors @gig.errors.full_messages
		end
	end

	def show
		@gig = Gig.gig_info(find_gig,token)
		render :json => {:result => true,:object => @gig}
	end

	def search
		user = User.get_user(token)
		@gigs = Gig.search(params,token)
	    render :json => {:result => true, :object => @gigs,:is_pending_review => Gig.pending_review(user.id),:is_unseen_request => Gig.is_unseen_request(user.id),
			:is_unseen_message => Message.is_unseen_message(user.id)}
	end

	def category
		@gig_ids = Gig.where(category_id: params[:id]).pluck(:id)
		@gigs = Gig.gig_data(@gig_ids,token,featured,query)
		render :json => {:result => true,:object => @gigs}
	end

	def destroy
		find_gig.update(status: 2)
		render :json => {status: 200}
	end

    def change_is_active
    	if Gig.exists?(:id => params[:id])
    		value = Gig.find(params[:id]).is_active
    		if value == false || value == nil
    			Gig.where(:id => params[:id]).update_all(:is_active => true,:updated_at => Time.now)
    		    Gig.bookmark_notification(token,params[:id])
    		    render :json => {:result => true,:object => [:is_active => true]}
    		else
    			Gig.where(:id => params[:id]).update_all(:is_active => false)
    		    render :json => {:result => true,:object => [:is_active => false]}
    		end
    	else
    		render :json => {:result => false,:message => t('gigs.change_is_active.error')}
    	end
	end

    def gigs_params
    	params.require(:gig).permit(:title,:price,:is_active,:status,:category_id,:neighborhood_ids)
    end

    def find_gig
      Gig.find_by("id = ? AND status != ?",params[:id],'2')
    end

    def featured
    	params[:featured]
    end

    def query
    	params[:query]
    end




end

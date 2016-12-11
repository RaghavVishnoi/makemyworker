class Api::V1::BookmarksController < Api::V1::ApisController


	def index
		@bookmarks = Bookmark.where(:user_id => User.get_user(token).id)
		render :json => {:result => true,:object => @bookmarks}
	end

	def create
		@user_id = User.get_user(token).id
		@gig_id = gig_id
		@bookmark_exist = Bookmark.exists?(gig_id: @gig_id,user_id: @user_id)
		if @bookmark_exist
			Bookmark.find_by(gig_id: @gig_id,user_id: @user_id).delete
			render :json => {:result => true,:is_bookmarked => false}
		else
			@bookmark = Bookmark.new(gig_id: @gig_id,user_id: @user_id)
			if @bookmark.save
				render :json => {:result => true, :is_bookmarked => true}
			else
				bookmark_errors @bookmark.errors.full_messages
			end
	    end
	end

	def gig_id
		params[:id]
	end

end
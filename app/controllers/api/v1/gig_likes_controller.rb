class Api::V1::GigLikesController < Api::V1::ApisController
	skip_before_action :authenticate, only: [:create,:show,:destroy,:users]

	def create
		if GigLike.exists?(gig_id: params[:id], user_id: User.get_user(token).id)
			GigLike.find_by(:gig_id => params[:id],:user_id => User.get_user(token).id).destroy
	        render :json => {:result => false}
	    else
	        @gig_like = GigLike.new(gig_id: params[:id], user_id: User.get_user(token).id)
			if @gig_like.save
				render :json => {:result => true}
			else
				render_errors @gig_like.errors.full_messages
			end
	    end		
	end

	def show
		if GigLike.exists?(gig_id: params[:id], user_id: User.get_user(token).id)
			render :json => {:result => true}
		else
			render :json => {:result => false}
		end
	end

	def users
		@gig_users = GigLike.where(:gig_id => params[:id]).pluck(:user_id)
		@users = User.where(:id => @gig_users)
		render :json => {:result => true,:object => @users}

	end

	def destroy
		@gig_like = GigLike.find_by(:gig_id => params[:id],:user_id => User.get_user(token).id)
		if @gig_like != nil
		  @gig_like.destroy	
		  render :json => {:result => true}
		else
		  render :json => {:result => false}
		end
	end

end	
class Api::V1::ImagesController < Api::V1::ApisController

	def create
        @image = Image.new(image_params)                            
	    if @image.save
	        image = ImageSerializer.new(@image, :root => false)
	        user = get_user
	        if Image.exists?(imageable_id: user.id)
	      	    Image.where(imageable_id: user.id).destroy_all
	      	    delete_directory
	        end
            photo_url =  base_url.to_s+image.image_url.to_s 
            @image.update(imageable_id: get_user.id,imageable_type: 'UserProfile')  
            User.where(id: user.id).update_all(photo_url: photo_url)     
		  	@user = User.user_data(token)
            render :json => { :result => true, :image => @user}        	      
	    else
	        render :json => { :result => false, :errors => { :messages => @image.errors.full_messages } }
	    end
    end
  
    def image_params
      params.require(:image).permit(:image)
    end

    def get_user
    	User.get_user(token)
    end

    def find_prev_path
    	user = get_user
    	if user.photo_url != nil
    		path = user.photo_url.reverse.split('/',2)
    	end
    end

    def delete_directory
        FileUtils.rm_rf(find_prev_path)
    end

    def base_url
        if Rails.env == 'development'
            DEVELOPMENT_URL
        elsif Rails.env == 'staging'
            STAGING_URL
        else
            PRODUCTION_URL
        end                
    end

end
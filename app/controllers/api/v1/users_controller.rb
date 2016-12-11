class Api::V1::UsersController < Api::V1::ApisController
  skip_before_action :authenticate, only: [:create]

  def create
   #############if ligin via email######################
    if login_via == EMAIL || signup_via == EMAIL
      @user = ClearanceAuth.user_from_params(user_params)
      @user_exists = User.exists?(:email => @user.email)
      if @user_exists
        if params.has_key?(:signup_via)
          render :json => {:errors  => [t('users.signup.exist.error')]}
        else
          @user = ClearanceAuth.authenticate(params)
          if @user != nil
            logged_in_device(@user.id)
            user = User.user_data(@user.token)
            render :json => {:result => true,:object => user}
          else
            render :json => {:errors  => [t('users.login.error')]}
          end
        end
      else
        if params.has_key?(:login_via)
          render :json => {:errors  => [t('users.login.error')]}
        else
          if @user.save
            user = User.user_data(@user.token)
            render :json => {:result => true,:object => user}
          else
            render_errors @user.errors.full_messages
          end
        end
      end
   else
    #################if login via facebook###################
      @user = User.new(
        user_params.
          merge(extra_facebook_information).
          merge(token: Token.new.generate).
          merge(password: 'none')
      )
      @user_exists = User.where(:facebook_user_id => @user.facebook_user_id).first
      if @user_exists
        # Update the User Facebook Token if changed
        if @user_exists.facebook_user_token != @user.facebook_user_token
          @user_exists.update_attributes(:facebook_user_token => params[:user][:facebook_user_token])
          @user_exists.reload
        end
        logged_in_device(@user_exists.id)
        @user = @user_exists
        @is_facebook_verified = User.is_facebook_verified(@user.id)
        render :show, status: 201
      else
        # User does not exists so create a new User
        user =  User.where('lower(email) = ?', @user[:email].downcase).first
        if user != nil
          logged_in_device(user.id)
          user.update_attributes(user_params.merge(extra_facebook_information))
          user.update(photo_url: ProfilePictureFinder.new(user).url)
          user[:is_facebook_verified] = User.is_facebook_verified(user.id)
          render :json => user
        else
          if @user.save
            @user.update(photo_url: ProfilePictureFinder.new(@user).url)
            Friender.new(@user).autofriend
            @is_facebook_verified = User.is_facebook_verified(@user.id)
            render :show, status: 201
          else
            render_errors @user.errors.full_messages
          end
        end

      end
    end
    #################################################
  end

  def show
    if params[:id] == SELF
      @user = User.user_with_recent_activity(token)
      render :json => @user
    else
      @user = User.find(params[:id])
      if @user
        @is_facebook_verified = User.is_facebook_verified(@user.id)
        if @user == current_user
          render :show
        else
          render partial: 'user', locals: {user: @user}
        end
      else
        render json: { errors: [t('users.show.error')] }, status: 404
      end
    end
  end

  def update
    @user = User.find_by(token: token)
    if user_params.has_key?(:username)
      if User.exists?(username: user_params[:username])
        render :json => {:errors => [t('users.update.username.error')]}
      else
        if @user.update_attributes(user_params)
          user = User.user_data(@user.token)
          render :json => {:result => true,:object => user}
        else
          render_errors @user.errors.full_messages
        end
      end
    else
      if @user.update_attributes(user_params)
         @is_facebook_verified = User.is_facebook_verified(@user.id)
         user = User.user_data(@user.token)
         render :json => {:result => true,:object => user}
      else
          render_errors @user.errors.full_messages
      end
    end
  end

  def seller
    user = User.is_seller(params[:user][:is_seller],token)
    render :json => {:result => true,:object => user}
  end

  def gigs
    gig_ids = User.gig(token)
    @gigs = Gig.gig_data(gig_ids,token,featured,query)
    render :json => {:result => true,:object => @gigs}
  end

  def logout
    User.where(token: token).update_all(logged_in: false)
    render :json => {:result => true,:message => "successfully logout!"}
  end

  def login_via
    params[:login_via]
  end

  def featured
    params[:featured]
  end

  def query
    params[:query]
  end

  def signup_via
    params[:signup_via]
  end

  def logged_in_device(user_id)
      User.where(id: user_id).update_all(logged_in: true)
  end

  def facebook_verification
      facebook_user_id = extra_facebook_information[:facebook_user_id]
      if User.exists?(facebook_user_id: facebook_user_id)
        render :json => {:result => false,:message => "Sorry this facebook account has already been taken!"}
      else
          user = User.find_by(token: token)
          user.update_attributes(user_params.except!([:email,:first_name,:last_name]).merge(facebook_user_id: facebook_user_id))
          Friender.new(user).autofriend
          render :json => {:result => true,:message => "Successfully verified!"}
      end
  end

  private

  def user_params
    params.require(:user).
      permit(
        :first_name,
        :last_name,
        :email,
        :username,
        :facebook_user_id,
        :facebook_user_token,
        :gender,
        :birthday,
        :bio,
        :last_known_location,
        :time_zone_name,
        :city_id,
        :is_seller,
        :bgcheck_verified,
        :password,
        :bgcheck_approved,
        :image_id

      )
  end

  def extra_facebook_information
    {
      first_name: facebook_client.first_name,
      last_name: facebook_client.last_name,
      email: facebook_client.email,
      birthday: facebook_client.birthday,
      facebook_user_id: facebook_client.user_id,
      gender: facebook_client.gender,
    }
  end

  def facebook_client
    @facebook_client ||= FacebookClient.new(facebook_user_token)
  end

  def facebook_user_token
    params[:user][:facebook_user_token]
  end





end

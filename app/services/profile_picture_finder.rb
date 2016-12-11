class ProfilePictureFinder
  GRAPH_API = "http://graph.facebook.com/v2.3/"
  PROFILE_PICTURE_WIDTH = 500
  PROFILE_PICTURE_HEIGHT = 500

  def initialize(user)
    @user = user
  end

  def url
    GRAPH_API +
      "#{facebook_user_id}/picture" +
      "?height=#{PROFILE_PICTURE_HEIGHT}&width=#{PROFILE_PICTURE_WIDTH}"
  end

  private

  def facebook_user_id
    @user.facebook_user_id
  end
end

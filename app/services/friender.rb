# Handles friending users in Circus. For example, it can autofriend all of your
# Facebook friends that have also authorized the Circus Facebook application.
class Friender
  def initialize(user)
    @user = user
  end

  def autofriend
    friend_ids.each { |friend_id| friend(friend_id) }
  end

  private

  def friend(new_friend_id)
    Friendship.create(user_id: user.id, friend_id: new_friend_id, initiated_by: user.id)
    Friendship.create(user_id: new_friend_id, friend_id: user.id, initiated_by: user.id)
  end

  def friend_ids
    friends_on_facebook.pluck(:id)
  end

  def friends_on_facebook
    User.where(facebook_user_id: facebook_client.facebook_friend_ids)
  end

  def facebook_client
    FacebookClient.new(user.facebook_user_token)
  end

  attr_reader :user
end

class Friendships
  def initialize(friend_id, current_user)
    @friend_id = friend_id
    @current_user = current_user
  end

  def create
    @friend = find_friend

    create_friendship(@friend.id)
  end

  def destroy
    @friend = find_friend

    destroy_friendship(@friend.id)
  end

  def accept
    @friend = find_friend

    accept_friendship(@friend.id)
  end


  def errors
    # {
    #   friendship: friendship_errors
    # }
  end

  private

  attr_reader :current_user, :venue_params, :plan_params

  def find_friend
    User.find(@friend_id)
  end

  def friendship_exists
    Friendship.where(user_id: @current_user.id, friend_id: @friend.id).first
  end

  def create_friendship(new_friend_id)
    if !friendship_exists
      Friendship.create(user_id: current_user.id, friend_id: new_friend_id, initiated_by: current_user.id, status: 0)
      Friendship.create(user_id: new_friend_id, friend_id: current_user.id, initiated_by: current_user.id, status: 0)
    else
      Friendship.where(user_id: current_user.id, friend_id: new_friend_id)
                .update_all(initiated_by: current_user.id, deleted_by: nil, status: 0, deleted_at: nil)

      Friendship.where(user_id: new_friend_id, friend_id: current_user.id)
                .update_all(initiated_by: current_user.id, deleted_by: nil, status: 0, deleted_at: nil)
    end
  end

  def destroy_friendship(friend_id)
    if friendship_exists #update(deleted: true, status: 2)

      Friendship.where(user_id: current_user.id, friend_id: friend_id)
                .update_all(deleted_by: current_user.id, status: 2, deleted_at: Time.now)

      Friendship.where(user_id: friend_id, friend_id: current_user.id)
                .update_all(deleted_by: current_user.id, status: 2, deleted_at: Time.now)

    end
    true
  end

  def accept_friendship(friend_id)
    if friendship_exists #update(deleted: true, status: 2)

      Friendship.where(user_id: current_user.id, friend_id: friend_id)
                .update_all(status: 1)

      Friendship.where(user_id: friend_id, friend_id: current_user.id)
                .update_all(status: 1)

    end
    true
  end

  def friendship_errors
    friendship.errors.full_messages
  end
end

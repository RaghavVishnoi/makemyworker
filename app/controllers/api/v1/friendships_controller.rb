class Api::V1::FriendshipsController < Api::V1::ApisController

  def index
    @friends = current_user.friendships.where(status: 1).joins(:friend).order("first_name asc, last_name asc")
    # @friends = current_user.friendships.all

    render :index
  end

  def create
    @friendship_creator = Friendships.new(
      params[:friend_id],
      current_user
    )

    if @friendship_creator.create
      render json: {}, status: 201
    else
      render_errors @friendship_creator.errors
    end

  end

  def destroy
    @friendship_destory = Friendships.new(
      params[:friend_id],
      current_user
    )

    if @friendship_destory.destroy
      render json: {}, status: 200
    else
      render_errors @friendship_destory.errors
    end
  end

  def accept
    @friendship_accept = Friendships.new(
      params[:friend_id],
      current_user
    )

    if @friendship_accept.accept
      render json: {}, status: 200
    else
      render_errors @friendship_accept.errors
    end
  end

  def pending
    @friends = current_user.friendships.where(status: 0).joins(:friend).order("first_name asc, last_name asc")

    render :index
  end
end

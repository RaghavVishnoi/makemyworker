class Friendship < ActiveRecord::Base
  acts_as_paranoid
  # time_for_a_boolean :deleted
  after_save :recent_activity
  after_save :notify_user

  belongs_to :user
  belongs_to :friend, class_name: "User"

  validates :user_id, presence: true, uniqueness: { scope: :friend_id }
  validates :friend_id, presence: true
  validate :user_cannot_friend_themselves

  def self.friend_ids_of(user)
    where("user_id = :id AND status = 1", id: user.id).
      distinct.
      pluck(:friend_id, :user_id).flatten - [user.id]
  end

  def mark_as_deleted
    update(deleted: true, status: 2)
  end

  private

  def user_cannot_friend_themselves
    if user_id == friend_id
      errors.add(:user_id, "User cannot friend themselves")
    end
  end

  def notify_user
    message = "Your friend #{User.find(friend_id).first_name} joined pinch!"
    Notifications.notification(user_id,message,'recentActivity')
  end

  def recent_activity
    message = "Your friend #{User.find(friend_id).first_name} joined pinch!"
    RecentActivity.create(user_id: user_id,message: message,sender_id: friend_id)
  end

end

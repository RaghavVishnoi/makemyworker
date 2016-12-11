class User < ActiveRecord::Base
  include Clearance::User

  GENDER = %w(male female notspecified).freeze

  acts_as_paranoid
  before_save :generate_token
  before_save :default_values
  after_save :genrate_referral_code

  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :requests
  has_many :images, :as => :imageable, :dependent => :destroy


  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, :email => { allow_blank: true}
  validate :facebook_user_id
  validate :facebook_user_token
  validate :token
  validate :is_seller
  #validates :gender, inclusion: { in: GENDER }
  validate :gender
  validate :photo_url
  validate :logged_in
  validate :bgcheck_approved

  def name
    first_name + " " + last_name
  end

  def friends
    self.class.where(id: friend_ids)
  end

  def friend_ids
    Friendship.friend_ids_of(self) + [id]
  end

  def link_ids
    ids_of_friends = friend_ids
    ids_to_exclude = [id] + friend_ids
    self.class.where(id: ids_of_friends).flat_map(&:friend_ids) - ids_to_exclude
  end

  def and_friends
    self.class.where(id: [id] + friend_ids)
  end

  def self.get_user(token)
    User.find_by(:token => token)
  end

  def self.gig(token)
    Gig.where(:user_id => User.get_user(token).id).pluck(:id)
  end

  def self.user_data(token)
    data = {}
    user = User.find_by(token: token)
    data[:id] = user.id
    data[:first_name] = user.first_name
    data[:last_name] = user.last_name
    data[:name] = user.first_name+" "+user.last_name
    data[:username] = user.username
    data[:email] = user.email
    data[:bio] = user.bio
    data[:photo_url] = user.photo_url
    data[:gender] = user.gender
    data[:birthday] = user.birthday
    data[:token] = user.token
    data[:last_known_location] = user.last_known_location
    data[:city_id] = user.city_id
    data[:is_seller] = user.is_seller
    data[:bgcheck_verified] = user.bgcheck_verified
    data[:user_type] = user.user_type
    data[:facebook_user_id] = user.facebook_user_id
    data[:facebook_user_token] = user.facebook_user_token
    data[:account_balance] = get_account_balance(user.id)
    data[:is_facebook_verified] = is_facebook_verified(user.id)
    data[:bgcheck_approved] = user.bgcheck_approved
    data[:referral_code] = referral_code(user.id)
    data
  end

  def self.get_account_balance(user_id)
      credits = Credit.find_by(user_id: user_id)
      if credits != nil
        '%.2f' %credits.counts 
      else
        nil
      end
  end

  def self.is_facebook_verified(user_id)
    user = User.find(user_id)
    if user.facebook_user_id != nil
      true
    else
      false
    end
  end

  def self.update_username(username,token)
    user = User.find_by(token: token)
    user.update(:username => username)
    user_data(token)
  end

  def self.is_seller(value,token)
    user = User.find_by(token: token)
    user.update(:is_seller => value)
    user_data(token)
  end

  def self.user_with_recent_activity(token)
    user = user_data(token)
    recent_activities = RecentActivity.recent_activity_data(get_user(token).id).reverse
    user[:recent_activities] = recent_activities
    user
  end

  def self.referral_code(user_id)
    ReferralCode.find_by(user_id: user_id).code
  end

  private
    def generate_token
      self.token ||= Token.new.generate
      self.is_seller ||= 'false'
    end

  def image_ids_string=(str)
    self.image_ids = str.split(',')
  end

  def genrate_referral_code
    number = Random.new.rand(10..99)
    code = self.first_name.upcase+number.to_s
    if !ReferralCode.exists?(user_id: self.id)
      ReferralCode.create!(code: code,user_id: self.id)
    end
  end

  def add_photo_url
    self.photo_url ||= ProfilePictureFinder.new(self).url
  end

  def default_values
    self.logged_in ||= true
  end
end

class FacebookClient
  def initialize(token)
    @client = Koala::Facebook::API.new(token)
  end

  def user_id
    basic_information["id"]
  end

  def birthday
    if basic_information["birthday"].present?
      Date.strptime(basic_information["birthday"], "%m/%d/%Y")
    else
      ""
    end
  end

  def first_name
    basic_information["first_name"]
  end

  def last_name
    basic_information["last_name"]
  end

  def email
    basic_information["email"]
  end

  def gender
    if basic_information["gender"].present?
      basic_information["gender"]
    else
      "notspecified"
    end
  end

  def facebook_friend_ids
    friends_response.map { |friend| friend["id"] }
  end

  private

  attr_reader :client

  def basic_information
    @basic_information ||= client.get_object("me")
  end

  def friends_response
    @friends_response ||= client.get_connections("me", "friends?limit=5000")
    puts "======================================================"
    puts @friends_response.inspect
    @friends_response ||= client.get_connections("me", "friends?limit=5000")
  end
end

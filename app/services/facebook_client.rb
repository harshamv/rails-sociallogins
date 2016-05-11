class FacebookClient
  def initialize(token)
    @client = Koala::Facebook::API.new(token)
  end

  def user_id
    basic_information["id"]
  end

  def first_name
    basic_information["first_name"]
  end

  def last_name
    basic_information["last_name"]
  end

  def name
    basic_information["name"]
  end

  def email
    basic_information["email"]
  end

  def bio
    basic_information["bio"]
  end

  def location
    basic_information["location"].present? ? basic_information["location"]["name"] : ""
  end

  def birthday
    basic_information["birthday"].present? ? Date.strptime(basic_information["birthday"], "%m/%d/%Y") : ""
  end

  def gender
    basic_information["gender"].present? ? basic_information["gender"] : "not_specified"
  end

  def profile_picture_url
    profile_picture_information["url"].present? ? profile_picture_information["url"] : ""
  end

  def no_of_friends
    friends_information["total_count"].present? ? friends_information["total_count"] : ""
  end

  private

  attr_reader :client

  def basic_information
    @basic_information ||= client.get_object("me?fields=id,first_name,last_name,name,bio,about,birthday,email,timezone,gender,location,hometown,currency,locale,devices")
  end

  def profile_picture_information
    @profile_picture_information ||= client.get_connection("me", "picture?redirect=false")
    return @profile_picture_information["data"]
  end

  def friends_information
    @friends_information = client.get_connection("me", "friends",api_version:"v2.0").raw_response["summary"]
  end
end

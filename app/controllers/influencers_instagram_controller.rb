class InfluencersInstagramController < Api::V1::ApiController
  require "instagram"

  def create

    Instagram.configure do |config|
      config.client_id = "692379b5fd484fd393ca36ef76e917fc"
      config.client_secret = "66991d56dea4481487e2542efec4c455"
    end

    puts "======================================================"
    p params.inspect
    puts "======================================================"

    response = Instagram.get_access_token(params[:code], :redirect_uri => call_back_url)

    puts "======================================================"
    p response[:access_token].inspect
    puts "======================================================"


    # @influencer = Influencer.new(first_name: instagram_client.full_name,
    #                              bio: instagram_client.bio,
    #                              profile_picture_url: instagram_client.profile_picture)
    #
    # @influencer.influencer_authorizations.build(
    #                 provider: 'instagram',
    #                 provider_uid: instagram_client.id,
    #                 oauth_token: session[:access_token])
    #
    # @influencer.save()
    render json: response
  end


  private


  def instagram_client

    Instagram.configure do |config|
      config.client_id = "692379b5fd484fd393ca36ef76e917fc"
      config.client_secret = "66991d56dea4481487e2542efec4c455"
    end

    puts params.inspect
    #
    # response = Instagram.get_access_token(params[:code], :redirect_uri => call_back_url)
    #
    # puts "======================================================"
    # puts response.inspect
    # session[:access_token] = response.access_token
    # client = Instagram.client(:access_token => session[:access_token])
    # user = client.user
  end

  def call_back_url
    "http://lvh.me:3000/auth/instagram"
  end

  def twitter_access_token_secret
    params[:influencer][:twitter_access_token_secret]
  end

end

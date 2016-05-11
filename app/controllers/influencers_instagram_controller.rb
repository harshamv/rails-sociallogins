class InfluencersInstagramController < Api::V1::ApiController
  require "instagram"

  def create
    @influencer = Influencer.new(first_name: instagram_client.full_name,
                                 username: instagram_client.username,
                                 bio: instagram_client.bio,
                                 no_of_friends: instagram_client.counts.followed_by,
                                 profile_picture_url: instagram_client.profile_picture)

    @influencer.influencer_authorizations.build(
                    provider: 'instagram',
                    provider_uid: instagram_client.id,
                    oauth_token: session[:access_token])

    @influencer.save()
    render plain: @influencer.inspect
  end


  private


  def instagram_client
    @access_token ||= instagram_token
    @user ||= instagram_user
  end


  def instagram_token
    Instagram.configure do |config|
      config.client_id = "979d4e4e56e843a696090b104224163f"
      config.client_secret = "ced0f812bd454381b060337f4b3cd8ed"
    end

    response ||= Instagram.get_access_token(params[:code], :redirect_uri => call_back_url)
    session[:access_token] = response.access_token
  end

  def instagram_user
    client = Instagram.client(:access_token => session[:access_token])
    user = client.user
  end

  def call_back_url
    "http://lvh.me:3000/auth/instagram"
  end

end

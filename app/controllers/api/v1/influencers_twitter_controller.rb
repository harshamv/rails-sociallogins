class Api::V1::InfluencersTwitterController < Api::V1::ApiController
  # skip_before_action :authenticate, only: [:create]

  def create
    @influencer = Influencer.new(first_name: twitter_client.name,
                                 bio: twitter_client.description,
                                 location: twitter_client.location,
                                 no_of_friends: twitter_client.followers_count,
                                 profile_picture_url: twitter_client.profile_background_image_url)

    @influencer.influencer_authorizations.build(
                    provider: 'twitter',
                    provider_uid: twitter_client.id,
                    oauth_token: twitter_access_token)

    @influencer.save()
    render plain: @influencer.inspect
  end


  private


  def twitter_client
    @twitter_client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = "A7N4GKxektczMk2eZRUg3Dr8h"
      config.consumer_secret     = "hHFELzICFBc4CXBZnK1RSJANxLDMnJwN7VjeLTOMwzCupiMlnE"
      config.access_token        = twitter_access_token
      config.access_token_secret = twitter_access_token_secret
    end
    return @twitter_client.user
  end

  def twitter_access_token
    params[:influencer][:twitter_access_token]
  end

  def twitter_access_token_secret
    params[:influencer][:twitter_access_token_secret]
  end

end

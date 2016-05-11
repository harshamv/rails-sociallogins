class Api::V1::InfluencersController < Api::V1::ApiController
  # skip_before_action :authenticate, only: [:create]

  def create
    @influencer = Influencer.new(first_name: facebook_client.first_name,
                                 last_name: facebook_client.last_name,
                                 email: facebook_client.email,
                                 bio: facebook_client.bio,
                                 date_of_birth: facebook_client.birthday,
                                 gender: facebook_client.gender,
                                 location: facebook_client.location,
                                 no_of_friends: facebook_client.no_of_friends,
                                 profile_picture_url: facebook_client.profile_picture_url)

    @influencer.influencer_authorizations.build(
                    provider: 'facebook',
                    provider_uid: facebook_client.user_id,
                    oauth_token: facebook_user_token,
                    social_account: '')

    @influencer.save()
    render plain: @influencer.inspect
  end


  private

  def influencer_params
    params.require(:influencer).
      permit(
        :first_name,
        :last_name,
        :email,
        :username,
        :gender,
        :date_of_birth
      )
  end

  def extra_facebook_information
    {
      first_name: facebook_client.first_name,
      last_name: facebook_client.last_name,
      email: facebook_client.email,
      date_of_birth: facebook_client.birthday,
      gender: facebook_client.gender,
    }
  end

  def facebook_client
    @facebook_client ||= FacebookClient.new(facebook_user_token)
  end

  def facebook_user_token
    params[:influencer][:facebook_user_token]
  end

end

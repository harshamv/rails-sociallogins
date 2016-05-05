class InstagramPostController < ApplicationController
  before_action :set_influencer
  before_action :instagram_client

  def index
  end

  private

  def set_influencer
    @influencer = Influencer.find(params[:id])
  end


  def instagram_client
    Instagram.configure do |config|
      config.client_id = "979d4e4e56e843a696090b104224163f"
      config.client_secret = "ced0f812bd454381b060337f4b3cd8ed"
    end
    @instagram_client ||= Instagram.client(:access_token => @influencer.influencer_authorizations[0].oauth_token)
  end

  def call_back_url
    "http://lvh.me:3000/auth/instagram"
  end



end

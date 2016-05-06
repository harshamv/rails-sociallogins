class TwitterPostController < ApplicationController
  require 'open-uri'

  before_action :set_influencer
  before_action :set_client, only: [:show, :create]

  def index
    if (@influencer.influencer_authorizations[0].social_account).nil?
      @post_list = []
    else
      @post_list = (@influencer.influencer_authorizations[0].social_account).split(',')
    end
  end

  def show

    begin
      @post_details = @twitter_client.status(params["postid"])

    rescue Exception => exc
       if exc.code == 144 && exc.message == "No status found with that ID."
         flash[:notice] = "This tweet is removed from Twitter"
         redirect_to(:action => 'index')
       end
    end
  end

  def new
  end

  def create
    if params.key?("message") && params["message"] != ""
      post_result = @twitter_client.update_with_media(params["message"], open(URI.parse('http://imaging.nikon.com/lineup/lens/zoom/normalzoom/af-s_dx_18-300mmf_35-56g_ed_vr/img/sample/img_01.jpg')))
    end

    social_account = @influencer.influencer_authorizations[0].social_account
    if social_account != "" && social_account != nil
      social_account += "," + (post_result["id"]).to_s
    else
      social_account = post_result["id"]
    end
    @influencer.influencer_authorizations[0].update({social_account: social_account})

    redirect_to twitter_post_index_path
  end

  private

  def set_influencer
    @influencer = Influencer.find(params[:id])
  end

  def set_client
    token = @influencer.influencer_authorizations[0].oauth_token
    @twitter_client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = "A7N4GKxektczMk2eZRUg3Dr8h"
      config.consumer_secret     = "hHFELzICFBc4CXBZnK1RSJANxLDMnJwN7VjeLTOMwzCupiMlnE"
      config.access_token        = token
      config.access_token_secret = "4TBCVE61S9vIAQbu0N89xRcCUeUufXfj6KwnURvJvBB1B"
    end
  end


end

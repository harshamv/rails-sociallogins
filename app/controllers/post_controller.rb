class PostController < ApplicationController
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
    @post_details = @client.get_object(params["postid"]+"?fields=full_picture,message,comments.limit(0).summary(true),likes.limit(0).summary(true),reactions.limit(0).summary(true),shares")
  end

  def new
  end

  def create
    if params.key?("source") && params["source"] != ""
      post_result = @client.put_connections("me", "photos", caption: params["message"], url: params["source"])
    end

    social_account = @influencer.influencer_authorizations[0].social_account
    if social_account != "" && social_account != nil
      social_account += "," + post_result["post_id"]
    else
      social_account = post_result["post_id"]
    end
    @influencer.influencer_authorizations[0].update({social_account: social_account})

    redirect_to post_index_path
  end

  private

  def set_influencer
    @influencer = Influencer.find(params[:id])
  end

  def set_client
    token = @influencer.influencer_authorizations[0].oauth_token
    #token = "EAACEdEose0cBANIvZAGCZA8Qzo17mPXiIJ7t9Q8ZA6H3kS0S0xzDUOt0XAHcCC2fmMZChkoRz7dFIfSD9CbBIoaRESJi1BPPpYBTNLoo9jLnOjXsA4cQUKqACKlWqHiGyuymwzSU0yGXOblyePnRo7F7Rx03FvfH2fIrGgIRMQZDZD"
    @client = Koala::Facebook::API.new(token)
  end

end

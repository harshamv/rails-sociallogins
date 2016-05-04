class InfluencerController < ApplicationController

  def index
    @influencers = Influencer.all
  end
end

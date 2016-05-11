class EngagementController < ApplicationController

  def create
    @engagement = Engagement.new(
      post_content: params["post_content"],
      post_file: params["post_file"]
    )
    print "----------1----------"
    print params["post_file"]
    print @engagement.inspect
    print "----------2---------"
    if @engagement.save
      render plain: "yes"
    else
      render plain: "no"
    end
  end

  def index
    @engagements = Engagement.all()
  end

  private

end

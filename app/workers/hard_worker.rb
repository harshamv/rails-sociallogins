class HardWorker
  include Sidekiq::Worker
  def perform()

    print "-----1-----"

    token = Influencer.first.influencer_authorizations[0].oauth_token
    @client = Koala::Facebook::API.new(token)

    @post_details = @client.get_object("816811745027019_1156775071030683?fields=full_picture,message,comments.limit(0).summary(true),likes.limit(0).summary(true),reactions.limit(0).summary(true),shares")
    print @post_details
    print "-----3-----"
  end
end

# -------- Setting the cron job execute every 1min ---------
# job = Sidekiq::Cron::Job.new(name: 'Hard worker - every 1min', cron: '*/1 19 * * *', class: 'HardWorker')
#
# unless job.save
#   puts job.errors #will return array of errors
# end

module Tweeter
  class PostTweetJob < ApplicationJob
    queue_as :default

    def perform(*args)
      tweet = args[0]
      job_id = args[1]
      if tweet.scheduled? && tweet.job_id == job_id
        post = tweet.post_to_twitter
        if post["data"]["id"]
          tweet.tweet_id = post["data"]["id"]
          tweet.status = "published"
          tweet.published_at = DateTime.now
          tweet.save
        end
      end  
    end
  end
end

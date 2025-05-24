module Tweeter
  class PostTweetJob < ApplicationJob
    queue_as :default

    def perform(*args)
      tweet = args[0]
      job_id = args[1]
      if tweet.scheduled? && tweet.job_id == job_id
        reply_to_tweet_id = ""
        tweet.thread.tweets.each do |tweet_in_thread|
          post = tweet_in_thread.post_to_twitter(reply_to: reply_to_tweet_id)
          # puts "-------------------------"
          # puts reply_to_tweet_id
          if post["data"]["id"]
            tweet_in_thread.tweet_id = post["data"]["id"]
            reply_to_tweet_id = tweet_in_thread.tweet_id
            tweet_in_thread.status = "published"
            tweet_in_thread.published_at = DateTime.now
            tweet_in_thread.save
          end
        end
      end  
    end
  end
end

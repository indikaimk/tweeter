module Tweeter
  module TweetsHelper

    def tweet_content(tweet)
      if tweet.content && !tweet.content.empty?
        return tweet.content
      else
        return "Blank tweet"
      end
    end
  end
end

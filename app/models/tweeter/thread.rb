module Tweeter
  class Thread < ApplicationRecord
    belongs_to :publisher, class_name: Tweeter.publisher_class.to_s
    has_many :tweets # , before_add: :set_tweet_sequence


    def get_next_sequence_number 
      self.tweets.by_thread_sequence.last.sequence + 1
    end

    def set_tweet_sequence(tweet) 
      # tweet.sequence = self.get_next_sequence_number
      puts "------------------------------------"
      tweet.update(sequence: self.get_next_sequence_number)
    end

    def publish_now 
      
    end

    def publish_later 
      self.job_id += 1
      if self.published_at 
        self.status = "scheduled"
        self.save
        PostTweetJob.set(wait_until: self.published_at).perform_later(self, self.job_id)
        return true
      end      
    end
  end
end

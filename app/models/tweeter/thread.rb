module Tweeter
  class Thread < ApplicationRecord
    belongs_to :publisher, class_name: Tweeter.publisher_class.to_s
    has_many :tweets


    def get_next_sequence_number 
      self.tweets.by_thread_sequence.last.sequence + 1
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

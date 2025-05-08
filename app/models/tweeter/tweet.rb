module Tweeter
  class Tweet < ApplicationRecord
    belongs_to :publisher, class_name: Tweeter.publisher_class.to_s
    
    enum :status, draft: 0, scheduled: 1, published: 2
  
    scope :latest, -> { order(updated_at: :desc) }
    scope :by_publised_at, -> { order( published_at: :asc) }

    def post_to_twitter 
      x_credentials = self.user.twitter_account.get_credentials_hash
      x_client = X::Client.new(**x_credentials)
      post = x_client.post("tweets", "{\"text\": #{self.content.dump}}")
      return post
    end
  
    def schedule_tweet 
      self.job_id += 1
      if self.published_at 
        self.status = "scheduled"
        self.save
        PostTweetJob.set(wait_until: self.published_at).perform_later(self, self.job_id)
        return true
      end
    end
  
    def post_now 
      self.published_at = nil
      self.job_id += 1
      self.status = "scheduled"
      self.save
      PostTweetJob.perform_later(self, self.job_id)
      return true
    end
  
  end


end

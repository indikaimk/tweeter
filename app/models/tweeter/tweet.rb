module Tweeter
  class Tweet < ApplicationRecord
    before_validation :add_tweet_to_thread
    has_one_attached :image

    belongs_to :publisher, class_name: Tweeter.publisher_class.to_s
    belongs_to :thread
    
    enum :status, draft: 0, scheduled: 1, published: 2, failed: 3
  
    scope :latest, -> { order(updated_at: :desc) }
    scope :by_publised_at, -> { order( published_at: :asc) }
    scope :lead_tweet, -> { where(sequence: 1) }
    scope :by_thread_sequence, -> { order(sequence: :asc) }

    def post_to_twitter(reply_to: "")
      x_credentials = self.publisher.twitter_account.get_credentials_hash
      x_client = X::Client.new(**x_credentials)
      tweet_body = {text: self.content}
      if self.image.representable?
        media_category = "tweet_image" # other options are: dm_image or subtitles; for videos or GIFs use chunked_upload  
        #Rails.error.handle do
          self.image.open do |image_file|
            media = ::X::MediaUploader.upload(client: x_client, file_path: image_file.path, media_category: media_category)
            tweet_body[:media] = {media_ids: [media["media_id_string"]]}
          end
        #end
      end
      if !reply_to.empty?
        tweet_body[:reply] = {in_reply_to_tweet_id: reply_to}
      end
      # puts "---------------------------------------------"
      # puts tweet_body
      # puts reply_to
      post = x_client.post("tweets", tweet_body.to_json)
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
  
    def publish_now 
      self.published_at = nil
      self.job_id += 1
      self.status = "scheduled"
      self.save
      PostTweetJob.perform_later(self, self.job_id)
      return true
    end

    def publish_later
      if self.published_at.nil?
        self.published_at = Time.now + 5.minutes # default to 5 minutes from now
      end
      self.job_id += 1
      self.status = "scheduled"
      self.save
      PostTweetJob.set(wait_until: self.published_at).perform_later(self, self.job_id)
      return true 
    end

    def is_lead_tweet? 
      if self.sequence == 1
        return true
      else
        return false
      end
    end

    private
      def add_tweet_to_thread 
        # if self.thread
        #   self.sequence = self.thread.get_next_sequence_number
        # else # Create new thread, if thread does not exists.
        #   self.thread = Thread.create(publisher: self.publisher)
        # end
        self.thread = self.thread || Thread.create(publisher: self.publisher)
      end

  end


end

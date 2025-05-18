module Tweeter
  class Thread < ApplicationRecord
    belongs_to :publisher, class_name: Tweeter.publisher_class.to_s
    has_many :tweets


    def get_next_sequence_number 
      self.tweets.by_thread_sequence.last.sequence + 1
    end
  end
end

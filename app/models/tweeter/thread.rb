module Tweeter
  class Thread < ApplicationRecord
    belongs_to :publisher, class_name: Tweeter.publisher_class.to_s
    has_many :tweets
  end
end

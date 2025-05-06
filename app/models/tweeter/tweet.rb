module Tweeter
  class Tweet < ApplicationRecord
    belongs_to :publisher, class_name: Tweeter.publisher_class.to_s
  end
end

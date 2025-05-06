module Tweeter
  class Account < ApplicationRecord
    belongs_to :publisher, class_name: Tweeter.publisher_class.to_s

    # before_validation :set_publisher

    # private
    #   def set_publisher
    #     self.publisher = Tweeter.publisher_class.constantize.find_or_create_by()
    #   end

  end
end

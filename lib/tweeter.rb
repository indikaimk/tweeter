require "tweeter/version"
require "tweeter/engine"

module Tweeter
  # Your code goes here...
  mattr_accessor :publisher_class

  def self.publisher_class
    @@publisher_class.constantize
  end

end

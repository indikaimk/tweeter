require "test_helper"

module Tweeter
  class TweetTest < ActiveSupport::TestCase
    # test "the truth" do
    #   assert true
    # end

    test "nee tweet sequence should be 1" do
      tweet = tweets(:tweet_1)
      assert_equal 1, tweet.sequence
    end
  end
end

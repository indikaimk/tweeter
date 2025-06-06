require "test_helper"

module Tweeter
  class TweetsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @tweet = tweeter_tweets(:one)
    end

    test "should get index" do
      get tweets_url
      assert_response :success
    end

    test "should get new" do
      get new_tweet_url
      assert_response :success
    end

    test "should create tweet" do
      assert_difference("Tweet.count") do
        post tweets_url, params: { tweet: { content: @tweet.content } }
      end

      assert_redirected_to tweet_url(Tweet.last)
    end

    test "should show tweet" do
      get tweet_url(@tweet)
      assert_response :success
    end

    test "should get edit" do
      get edit_tweet_url(@tweet)
      assert_response :success
    end

    test "should update tweet" do
      patch tweet_url(@tweet), params: { tweet: { content: @tweet.content } }
      assert_redirected_to tweet_url(@tweet)
    end

    test "should destroy tweet" do
      assert_difference("Tweet.count", -1) do
        delete tweet_url(@tweet)
      end

      assert_redirected_to tweets_url
    end
  end
end

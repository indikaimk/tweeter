class AddTweetIdToTweet < ActiveRecord::Migration[8.0]
  def change
    add_column :tweeter_tweets, :tweet_id, :string
  end
end

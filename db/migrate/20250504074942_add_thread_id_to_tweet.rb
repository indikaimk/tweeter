class AddThreadIdToTweet < ActiveRecord::Migration[8.0]
  def change
    add_column :tweeter_tweets, :thread_id, :integer
    add_index :tweeter_tweets, :thread_id
  end
end

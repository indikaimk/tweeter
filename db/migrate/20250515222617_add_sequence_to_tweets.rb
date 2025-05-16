class AddSequenceToTweets < ActiveRecord::Migration[8.0]
  def change
    add_column :tweeter_tweets, :sequence, :integer, default: 1
  end
end

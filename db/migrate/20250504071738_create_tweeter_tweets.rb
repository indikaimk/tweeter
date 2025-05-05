class CreateTweeterTweets < ActiveRecord::Migration[8.0]
  def change
    create_table :tweeter_tweets do |t|
      t.text :content
      t.datetime :published_at
      t.integer :job_id, default: 0
      t.integer :newsletter_id, index: true
      # t.references :account


      t.timestamps
    end
  end
end

class CreateTweeterThreads < ActiveRecord::Migration[8.0]
  def change
    create_table :tweeter_threads do |t|
      t.timestamps
      t.integer :newsletter_id, index: true
      # t.references :accounts
    end
  end
end

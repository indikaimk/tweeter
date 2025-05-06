class CreateTweeterThreads < ActiveRecord::Migration[8.0]
  def change
    create_table :tweeter_threads do |t|
      t.timestamps
      t.integer :publisher_id, index: true
      # t.references :accounts
    end
  end
end

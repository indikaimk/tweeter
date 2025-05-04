class CreateTweeterThreads < ActiveRecord::Migration[8.0]
  def change
    create_table :tweeter_threads do |t|
      t.timestamps
      t.references :account
    end
  end
end

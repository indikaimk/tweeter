class CreateTweeterAccounts < ActiveRecord::Migration[8.0]
  def change
    create_table :tweeter_accounts do |t|
      t.string :username
      t.string :api_key
      t.string :api_key_secret
      t.string :access_token
      t.string :access_token_secret
      t.integer :publisher_id, index: true

      t.timestamps
    end
  end
end

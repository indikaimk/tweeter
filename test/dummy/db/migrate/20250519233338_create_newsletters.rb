class CreateNewsletters < ActiveRecord::Migration[8.0]
  def change
    create_table :newsletters do |t|
      t.timestamps
    end
  end
end

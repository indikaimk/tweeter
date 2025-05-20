class AddJobIdToThread < ActiveRecord::Migration[8.0]
  def change
    add_column :tweeter_threads, :job_id, :integer, default: 0
  end
end

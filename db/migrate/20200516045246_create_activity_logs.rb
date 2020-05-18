class CreateActivityLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :activity_logs do |t|
      t.references :baby, index: true, foreign_key: true
      t.references :assistant, index: true, foreign_key: true
      t.references :activity, index: true, foreign_key: true
      t.datetime :start_time
      t.datetime :stop_time
      t.integer :duration
      t.text  :comments

      t.timestamps
    end
  end
end

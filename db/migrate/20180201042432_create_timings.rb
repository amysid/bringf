class CreateTimings < ActiveRecord::Migration[5.1]
  def change
    create_table :timings do |t|
      t.integer :day
      t.boolean :is_open, default: false
      t.datetime :open_time
      t.datetime :close_time
      t.boolean :published, default: false
      t.references :location, foreign_key: true
      t.timestamps
    end
  end
end

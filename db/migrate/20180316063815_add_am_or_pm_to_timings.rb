class AddAmOrPmToTimings < ActiveRecord::Migration[5.1]
  def change
    add_column :timings, :am_or_pm_open_time, :string
    add_column :timings, :am_or_pm_close_time, :string
    remove_column :timings, :open_time, :datetime
    remove_column :timings, :close_time, :datetime
    add_column :timings, :open_time, :string
    add_column :timings, :close_time, :string

  end
end

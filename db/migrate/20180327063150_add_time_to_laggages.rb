class AddTimeToLaggages < ActiveRecord::Migration[5.1]
  def change
  	add_column :laggages, :time, :time
  end
end

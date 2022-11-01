class AddTotalWeightToLaggages < ActiveRecord::Migration[5.1]
  def change
    add_column :laggages, :total_weight, :float
  end
end

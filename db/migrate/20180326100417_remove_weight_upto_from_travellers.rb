class RemoveWeightUptoFromTravellers < ActiveRecord::Migration[5.1]
  def change
    remove_column :travellers, :weight_upto, :string
    add_column :travellers, :weight_upto, :float
    add_column :travellers, :arrival_time, :time
    add_column :travellers, :departure_time, :time
  end
end

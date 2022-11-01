class AddmodeOfTravelToLaggages < ActiveRecord::Migration[5.1]
  def change
  
  add_column :laggages, :mode_of_travel, :string
  end
end

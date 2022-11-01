class AddPublishToLocations < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :publish, :boolean, default: false
  end
end

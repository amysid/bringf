class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.string   :location_name
      t.string   :country_code
      t.string   :phone_no
      t.string   :address
      t.string   :state
      t.string   :city
      t.string   :landmark
      t.string   :zip
      t.timestamps
    end
  end
end

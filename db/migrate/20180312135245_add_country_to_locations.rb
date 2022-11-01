class AddCountryToLocations < ActiveRecord::Migration[5.1]
  def change
  add_reference :locations, :country, foreign_key: true
  end
end

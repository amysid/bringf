class AddContinenttoCountries < ActiveRecord::Migration[5.1]
  def change
 add_column :countries, :continent, :string
  end
end

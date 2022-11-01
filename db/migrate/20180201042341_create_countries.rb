class CreateCountries < ActiveRecord::Migration[5.1]
  def change
    create_table :countries do |t|
      
      t.string :country_name
      t.string :iso_code
      t.float :tax_percentage, default: 0.0

      t.timestamps
    end
  end
end

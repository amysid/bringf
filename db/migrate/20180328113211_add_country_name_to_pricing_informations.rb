class AddCountryNameToPricingInformations < ActiveRecord::Migration[5.1]
  def change
    add_column :pricing_informations, :country_name, :string
  end
end

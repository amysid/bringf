class AddweightUnitToPackageDetails < ActiveRecord::Migration[5.1]
  def change
  	add_column :package_details, :weight_unit, :string
  end
end

class RemoveWeightFromPackageDetails < ActiveRecord::Migration[5.1]
  def change
    remove_column :package_details, :weight, :staring
    add_column :package_details, :weight, :float
  end
end

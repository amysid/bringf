class CreatePackageDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :package_details do |t|
      t.string :package_content
       t.string :package_image
       t.string :size
       t.string :weight
       t.references :laggage, foreign_key: true
      t.timestamps
    end
  end
end

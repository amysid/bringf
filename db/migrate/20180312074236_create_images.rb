class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.string :package_image
      t.references :package_detail, foreign_key: true
      t.timestamps
    end
  end
end

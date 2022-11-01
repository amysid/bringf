class CreateContents < ActiveRecord::Migration[5.1]
  def change
    create_table :contents do |t|
      t.string :title
      t.text :body
      t.string :slug
      t.string :meta_keyboard
      t.string :meta_description
      t.boolean :published, default: false 
      t.timestamps
    end
  end
end

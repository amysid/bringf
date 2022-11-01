class AddPublishedToCountry < ActiveRecord::Migration[5.1]
  def change
    add_column :countries, :published, :boolean, default: false
  end
end

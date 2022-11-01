class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.date :dob
      t.string :email
      t.string :password_digest
      t.string :phone_no
      t.string :country_code
      t.string :address
      t.string :country
      t.string :state
      t.string :city
      t.string :zip
      t.string :image
      t.timestamps
    end
  end
end



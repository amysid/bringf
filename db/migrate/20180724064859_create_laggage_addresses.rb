class CreateLaggageAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :laggage_addresses do |t|
      t.string :lat
      t.string :long
      t.string :address
      t.integer :user_id

      t.timestamps
    end
  end
end

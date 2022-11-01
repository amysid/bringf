class CreateLaggages < ActiveRecord::Migration[5.1]
  def change
    create_table :laggages do |t|
      t.datetime :date
      t.string :departure_country
      t.string :departure_state
      t.string :departure_city
      t.string :arrival_country
      t.string :arrival_state
      t.string :arrival_city
      t.string :description
      t.string :value_of_shipment
      t.bigint :receiver_id
      t.bigint :traveller_id
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end

class CreateTravellers < ActiveRecord::Migration[5.1]
  def change
    create_table :travellers do |t|
       t.string :weight_upto
       t.string :weight_unit
      t.string :mode_of_travel
      t.datetime :departure_date
      t.string :departure_address
      t.string :departure_country
      t.string  :departure_state
      t.string   :departure_city
      t.string   :departure_zip
      t.string :departure_meeting_address
      t.string :departure_meeting_country
      t.string  :departure_meeting_state
      t.string   :departure_meeting_city
      t.string   :departure_meeting_zip
      t.datetime :arrival_date
      t.string :arrival_address
      t.string :arrival_country
      t.string  :arrival_state
      t.string   :arrival_city
      t.string   :arrival_zip
      t.string :arrival_meeting_address
      t.string :arrival_meeting_country
      t.string  :arrival_meeting_state
      t.string   :arrival_meeting_city
      t.string   :arrival_meeting_zip
      t.string   :contact_person
      t.string   :contact_phone
      t.string :contact_country_code
      t.datetime   :last_date_to_recieve_item
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end



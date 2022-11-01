class CreateRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :ratings do |t|
       t.integer :sender_id
       t.integer :receiver_id
       t.integer :laggage_id
       t.integer :star 
       t.boolean :rating_status, default: false
       t.timestamps
    end
  end
end

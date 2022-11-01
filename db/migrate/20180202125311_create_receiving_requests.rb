class CreateReceivingRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :receiving_requests do |t|
     
     t.boolean :status, default: false
     t.references :laggage, foreign_key: true
     t.bigint :sender_id
     t.bigint :receiver_id
      t.timestamps
    end
  end
end

class CreateSendingRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :sending_requests do |t|
      
      t.boolean :status, default: false
      t.bigint :traveller_id
      t.bigint :sender_id
      t.references :laggage, foreign_key: true
      t.timestamps
    end
  end
end



  
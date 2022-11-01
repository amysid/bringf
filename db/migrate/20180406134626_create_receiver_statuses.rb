class CreateReceiverStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :receiver_statuses do |t|
      t.string :receiver_email
      t.integer :receiver_id
      t.integer :sender_id
      t.integer :laggage_id
      t.boolean :status , default: false

      t.timestamps
    end
  end
end

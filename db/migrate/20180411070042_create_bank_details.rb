class CreateBankDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :bank_details do |t|
      t.bigint :account_number
      t.string :holder_name
      t.string :spacial_code
      t.string :account_type
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end

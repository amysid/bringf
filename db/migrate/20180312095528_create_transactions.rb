class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.string :name
      t.date :date
      t.string :email
      t.float :total_amount, :default => 0.00
      t.float :admin_earning_by_traveller, default: 0.0
      t.float :admin_earning_by_shipper, default: 0.0
      t.references :laggage, foreign_key: true

      t.timestamps
    end
  end
end

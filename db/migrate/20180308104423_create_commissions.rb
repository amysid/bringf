class CreateCommissions < ActiveRecord::Migration[5.1]
  def change
    create_table :commissions do |t|
      t.float :traveller_commission
      t.float :shipper_commission
      t.string :commission_type
      t.references :pricing_information, foreign_key: true

      t.timestamps
    end
  end
end

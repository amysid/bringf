class RemoveCommissionTypeFromCommissions < ActiveRecord::Migration[5.1]
  def change
    remove_column :commissions, :commission_type, :string
    add_column :commissions, :traveller_commission_type, :string
    add_column :commissions, :traveller_percentage, :boolean
    add_column :commissions, :traveller_fixed, :boolean

    add_column :commissions, :shipper_commission_type, :string
    add_column :commissions, :shipper_percentage, :boolean
    add_column :commissions, :shipper_fixed	, :boolean
    add_reference :commissions, :country, foreign_key: true
  end
end

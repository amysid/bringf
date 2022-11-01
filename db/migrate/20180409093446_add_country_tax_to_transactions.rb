class AddCountryTaxToTransactions < ActiveRecord::Migration[5.1]
  def change
    add_column :transactions, :country_tax, :float
  end
end

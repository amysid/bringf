class AddrefundStatusToTransactions < ActiveRecord::Migration[5.1]
  def change
  	add_column :transactions, :refund_status,:boolean,default: false
  end
end

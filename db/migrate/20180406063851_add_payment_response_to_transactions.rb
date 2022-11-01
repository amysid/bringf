class AddPaymentResponseToTransactions < ActiveRecord::Migration[5.1]
  def change
    add_column :transactions, :payment_response, :text
    add_column :transactions, :stripe_transaction_id, :text
  end
end

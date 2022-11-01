class AddStatusToLaggages < ActiveRecord::Migration[5.1]
  def change
    add_column :laggages, :status, :integer
  end
end

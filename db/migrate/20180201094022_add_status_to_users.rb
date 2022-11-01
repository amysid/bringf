class AddStatusToUsers < ActiveRecord::Migration[5.1]
  def change
   add_column :users, :status, :string,default: "inactive"
   add_column :users, :is_block,:boolean,default: false
  end
end

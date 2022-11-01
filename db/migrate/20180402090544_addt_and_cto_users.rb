class AddtAndCtoUsers < ActiveRecord::Migration[5.1]
  def change
   add_column :users, :t_and_c, :boolean, default: false

   end 
end



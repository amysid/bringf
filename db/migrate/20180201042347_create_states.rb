class CreateStates < ActiveRecord::Migration[5.1]
  def change
    create_table :states do |t|
      t.string  :state_name
      t.string  :abbreviation
      t.boolean :published, default: false 
      t.timestamps
    end
  end
end

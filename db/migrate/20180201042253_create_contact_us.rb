class CreateContactUs < ActiveRecord::Migration[5.1]
  def change
    create_table :contact_us do |t|
      t.string :name
       t.string :reason_for_contacting
       t.string :message
       t.string :email
      t.timestamps
    end
  end
end

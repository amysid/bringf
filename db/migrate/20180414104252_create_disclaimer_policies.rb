class CreateDisclaimerPolicies < ActiveRecord::Migration[5.1]
  def change
    create_table :disclaimer_policies do |t|
       t.string :title
       t.text :body
      t.timestamps
    end
  end
end

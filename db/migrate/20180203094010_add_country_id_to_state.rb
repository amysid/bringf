class AddCountryIdToState < ActiveRecord::Migration[5.1]
  def change
    add_reference :states, :country, foreign_key: true
  end
end

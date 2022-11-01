class AddtravellerLaggageStatusToLaggages < ActiveRecord::Migration[5.1]
  def change
  	add_column :laggages, :traveller_laggage_status,:boolean,default: false
  end
end

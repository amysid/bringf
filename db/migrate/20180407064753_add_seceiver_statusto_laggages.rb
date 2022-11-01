class AddSeceiverStatustoLaggages < ActiveRecord::Migration[5.1]
  def change
  	add_column :laggages, :laggage_status,:boolean,default: false
  end
end

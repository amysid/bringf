class CreatePricingInformations < ActiveRecord::Migration[5.1]
  def change
    create_table :pricing_informations do |t|
      t.references :country, foreign_key: true
      t.float :weight_from
      t.string :weight_from_unit
      t.float :weight_to
      t.string :weight_to_unit
      t.float :by_road_price_regional
      t.float :by_track_price_regional
      t.float :by_air_price_regional
      t.float :by_water_price_regional
      t.float :by_road_price_national
      t.float :by_track_price_national
      t.float :by_air_price_national
      t.float :by_water_price_national
      t.float :by_road_price_international
      t.float :by_track_price_international
      t.float :by_air_price_international
      t.float :by_water_price_international
      t.boolean :is_publish, default: false
      t.timestamps
    end
  end
end

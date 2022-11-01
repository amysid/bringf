class PricingInformation < ApplicationRecord
  before_save :save_country_name
  belongs_to :country 
  has_many :commissions, dependent: :destroy 
  
  validates :weight_to, presence: true
  validates :weight_to_unit, presence: true
  validates :weight_from, presence: true
  validates :weight_from_unit, presence: true
  validates :by_road_price_regional, presence: true
  validates :by_track_price_regional, presence: true
  validates :by_air_price_regional, presence: true
  validates :by_water_price_regional, presence: true
  validates :by_road_price_national, presence: true
  validates :by_track_price_national, presence: true
  validates :by_air_price_international, presence: true
  validates :by_water_price_national, presence: true
  validates :by_road_price_international, presence: true
  validates :by_track_price_international, presence: true
  validates :by_air_price_international, presence: true
  validates :by_water_price_international, presence: true
  

def self.shipping_charges user_laggage
    pi = PricingInformation.where(country_name: user_laggage.departure_country)

    pi1 = pi.where('weight_from <= ? and weight_to >= ? and weight_from_unit = ?', user_laggage.total_weight, user_laggage.total_weight, user_laggage.package_details.first.weight_unit) rescue []
    weight_unit = pi1.first.try(:weight_from_unit)
    if user_laggage.departure_country != user_laggage.arrival_country
      bus_tax = pi1.first.try(:by_road_price_international)
      train_tax = pi1.first.try(:by_track_price_international)
      ship_tax = pi1.first.try(:by_water_price_international)
      plane_tax = pi1.first.try(:by_air_price_international)
    else
      if user_laggage.departure_country == user_laggage.arrival_country && user_laggage.departure_state != user_laggage.arrival_state
        bus_tax = pi1.first.try(:by_road_price_national)
        train_tax = pi1.first.try(:by_track_price_national)
        ship_tax = pi1.first.try(:by_water_price_national)
        plane_tax = pi1.first.try(:by_air_price_national)
      else
        bus_tax = pi1.first.try(:by_road_price_regional)
        train_tax = pi1.first.try(:by_track_price_regional)
        ship_tax = pi1.first.try(:by_water_price_regional)
        plane_tax = pi1.first.try(:by_air_price_regional)
      end
    end
    if user_laggage.mode_of_travel == "Bus"
      shipping_charges = bus_tax
    elsif user_laggage.mode_of_travel == "Train"
      shipping_charges = train_tax
    elsif user_laggage.mode_of_travel == "Plane"
      shipping_charges = plane_tax
    else
      shipping_charges = ship_tax
    end   
   #shipper calculations
    if pi1.first.try(:commissions).try(:first).try(:shipper_commission_type) == "shipper_fixed"
        admin_commission_from_shipper =  pi1.first.commissions.first.try(:shipper_commission)
    else
      percentage_value = pi1.first.try(:commissions).try(:first).try(:shipper_commission)
      admin_commission_from_shipper =  ((percentage_value / 100 ) * shipping_charges ).round(2) rescue nil
    end
     
     tax_percentage = Country.find_by(country_name: user_laggage.departure_country).try(:tax_percentage)
     tax = ((tax_percentage / 100 ) * shipping_charges).round(2) rescue nil
     
     total_price = (shipping_charges + admin_commission_from_shipper + tax).round(2) rescue nil
   #traveller calculations
    if pi1.first.try(:commissions).try(:first).try(:traveller_commission_type) == "traveller_fixed"
        admin_commission_from_traveller =  pi1.first.commissions.first.try(:traveller_commission)
    else
        percentage_value = pi1.first.try(:commissions).try(:first).try(:traveller_commission)
      admin_commission_from_traveller =  ((percentage_value / 100) *  shipping_charges).round(2) rescue nil
    end
     return tax, shipping_charges, admin_commission_from_shipper, total_price, admin_commission_from_traveller, weight_unit
   end


   def self.shipping_charges_show_to_traveller laggage_list
   arr = []
   laggage_list&.each do |user_laggage|
   hash = {}
    pi = PricingInformation.where(country_name: user_laggage.departure_country)
    pi1 = pi.where('weight_from <= ? and weight_to >= ?', user_laggage.total_weight, user_laggage.total_weight) rescue []
    if user_laggage.departure_country != user_laggage.arrival_country
       bus_tax = pi1.first.try(:by_road_price_international)
      train_tax = pi1.first.try(:by_track_price_international)
      ship_tax = pi1.first.try(:by_water_price_international)
      plane_tax = pi1.first.try(:by_air_price_international)
    else
        if user_laggage.departure_country == user_laggage.arrival_country && user_laggage.departure_state != user_laggage.arrival_state
          bus_tax = pi1.first.try(:by_road_price_national)
          train_tax = pi1.first.try(:by_track_price_national)
          ship_tax = pi1.first.try(:by_water_price_national)
          plane_tax = pi1.first.try(:by_air_price_national)
        else
          bus_tax = pi1.first.try(:by_road_price_regional)
          train_tax = pi1.first.try(:by_track_price_regional)
          ship_tax = pi1.first.try(:by_water_price_regional)
          plane_tax = pi1.first.try(:by_air_price_regional)
        end
    end
    if user_laggage.mode_of_travel == "Bus"
      hash["traveller_earning"] = bus_tax
    elsif user_laggage.mode_of_travel == "Train"
      hash["traveller_earning"] = train_tax
    elsif user_laggage.mode_of_travel == "Plane"
      hash["traveller_earning"] = plane_tax
    else
      hash["traveller_earning"] = ship_tax
    end   
    if pi1.first.try(:commissions).try(:first).try(:traveller_commission_type) == "traveller_fixed"
        hash["admin_commission_from_traveller"] =  pi1.first.commissions.first.try(:traveller_commission)
    else
        hash["percentage_value"] = pi1.first.try(:commissions).try(:first).try(:traveller_commission)
       hash["admin_commission_from_traveller"] =  ((hash["percentage_value"] / 100) *  hash["traveller_earning"]).round(2) rescue nil
    end
       hash["tax_percentage"] = Country.find_by(country_name: user_laggage.departure_country).try(:tax_percentage)
     hash["tax"] = ((hash["tax_percentage"] / 100 ) * hash["traveller_earning"]).round(2) rescue nil
     
     hash["total_price"] = ( hash["traveller_earning"] - hash["admin_commission_from_traveller"] - hash["tax"] ).round(2) rescue nil
     arr << hash
     end
       return arr
   end

  def save_country_name
    country_name = Country.find_by(id: self.country_id).country_name 
    self.country_name = country_name
  end

  def is_publish?
    self[:is_publish] ? 'Yes' : 'No'
  end
end

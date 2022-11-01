class PricingsController < ApplicationController

layout "website"
# @users = User.where("first_name ILIKE ? or last_name ILIKE ? or (first_name ILIKE ? and last_name ILIKE ? )"   ,"%#{params[:search]}%","%#{params[:search]}%", "%#{full_name[0]}","#{full_name[1]}%" )

def index
params[:user] = "active"
if  params["/pricings"].present?
	@search=true
	@pricing_informations = PricingInformation.joins(:country).select("pricing_informations.weight_from,pricing_informations.weight_from_unit, countries.country_name, pricing_informations.weight_to,pricing_informations.weight_to_unit,
    pricing_informations.by_road_price_regional,pricing_informations.by_track_price_regional,pricing_informations.by_air_price_regional,pricing_informations.by_water_price_regional,
	pricing_informations.by_road_price_national,pricing_informations.by_track_price_national,pricing_informations.by_air_price_national,pricing_informations.by_water_price_national,
	pricing_informations.by_road_price_international,pricing_informations.by_track_price_international,pricing_informations.by_air_price_international,pricing_informations.by_water_price_international").where(id: params["/pricings"]["pricing_information_id"])
 else  
@pricing_informations = PricingInformation.joins(:country).select("pricing_informations.weight_from,pricing_informations.weight_from_unit, countries.country_name, pricing_informations.weight_to,pricing_informations.weight_to_unit,
    pricing_informations.by_road_price_regional,pricing_informations.by_track_price_regional,pricing_informations.by_air_price_regional,pricing_informations.by_water_price_regional,
	pricing_informations.by_road_price_national,pricing_informations.by_track_price_national,pricing_informations.by_air_price_national,pricing_informations.by_water_price_national,
	pricing_informations.by_road_price_international,pricing_informations.by_track_price_international,pricing_informations.by_air_price_international,pricing_informations.by_water_price_international")
country_id_in_price = PricingInformation.all.pluck(:country_id)
@country_names = Country.where(id: country_id_in_price).pluck(:country_name)
end
respond_to do |format| 
        format.html
        format.js
      end
     end

 def find_weight_from_country
    cn = params[:country_name]
    country_id = Country.find_by(country_name: cn).try(:id)
    pi = PricingInformation.where(country_id: country_id)
    h = {}
    pi.map do |i|
      h[i.id] = i.weight_from.to_s + "" + i.weight_from_unit + " - " + i.weight_to.to_s + "" + i.weight_to_unit 
    end
    render json: {data: h}
  end


end



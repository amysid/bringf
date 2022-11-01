class Api::V1::PricingsController < ApplicationController





def pricing_country
a = []
country_id_in_price = PricingInformation.all.pluck(:country_id)
@country_names = Country.where(id: country_id_in_price).pluck(:country_name)
@country_names.each do |i|
h = {}
h["country_name"] = i
a << h
end
render json: {responseCode: 200, responseMessage: 'Country name list',
        country_name: a}
end
 
def find_weight_from_country
    b = []
    cn = params[:pricing_information][:country_name]
    country_id = Country.find_by(country_name: cn).try(:id)
    pi = PricingInformation.where(country_id: country_id)
    
    pi.map do |i|
       h = {}
      
       h["id"] = i.id
       h["weight"] = i.weight_from.to_s + "" + i.weight_from_unit + " - " + i.weight_to.to_s + "" + i.weight_to_unit
       b << h
  
    end
    # render json: {data: h}
    render json: {responseCode: 200, responseMessage: 'Weight of country',
        data: b}
end


def pricing_list
	@pricing_informations = PricingInformation.joins(:country).select("pricing_informations.weight_from,pricing_informations.weight_from_unit, countries.country_name, pricing_informations.weight_to,pricing_informations.weight_to_unit,
    pricing_informations.by_road_price_regional,pricing_informations.by_track_price_regional,pricing_informations.by_air_price_regional,pricing_informations.by_water_price_regional,
	pricing_informations.by_road_price_national,pricing_informations.by_track_price_national,pricing_informations.by_air_price_national,pricing_informations.by_water_price_national,
	pricing_informations.by_road_price_international,pricing_informations.by_track_price_international,pricing_informations.by_air_price_international,pricing_informations.by_water_price_international").where(id: params[:pricing][:weight_id])
	render json: {responseCode: 200, responseMessage: 'Pricing list of country',
        data: @pricing_informations}
 
end



 



end

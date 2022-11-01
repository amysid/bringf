class Api::V1::TravellersController < ApplicationController
before_action :find_user


  
 
  def traveler_form
    @traveller =  @current_user.travellers.new(traveller_params)  
    if @traveller.save
      @@laggage_list = Laggage.laggage_request(@traveller)
      @list_of_luggage = []
       @@laggage_list.each do |list|
       @laggage_list = list.slice(:id,:date,:departure_country,:departure_state,:departure_city,:arrival_country,:arrival_state,:arrival_city)
       image = list.package_details.first.images.first.package_image.url rescue nil
       h2 = { "image" => image}
       @list_of_luggage <<  @laggage_list.merge(h2) 

     end
      render json: {responseCode: 200, responseMessage: 'Luggage list',
        luggage_list: @list_of_luggage}
    else
      render 'new'
    end
  end







 def traveller_list
    @departure = params[:departure_address].split(",")
    @arrival = params[:arrival_address].split(",")
    @date = params[:departure_date]
    @traveller_date = Traveller.where('DATE(departure_date) = ?', @date)
    @list = @traveller_date.where("departure_city ILIKE ? or departure_state ILIKE ? or (departure_city ILIKE ? and  departure_state ILIKE ? ) and arrival_city ILIKE ? or arrival_state ILIKE ? or (arrival_city ILIKE ? and arrival_state ILIKE ? )"   ,"#{@departure[0]}","#{@departure[0]}", "#{@departure[0]}","#{@departure[1]}", "#{@arrival[0]}", "#{@arrival[1]}", "#{@arrival[0]}","#{@arrival[1]}")
    render :json => {:responseCode => 200,
     :responseMessage => 'Traveller List',
     :departure_location => @departure,
     :arrival_location => @arrival,
     :date =>  @date,
     :travellers => @list.count
   
     }

   end

  

   def view_request_list
   results = Geocoder.search([params[:lat], params[:long]]) if params[:lat].present? && params[:long].present?
   @laggage_list = Laggage.where(id: params[:laggage_id])
   lag_arr = []
   @lag_hash = {}
        @lag_hash[:date] = @laggage_list.first.date 
        @lag_hash[:departure_country] = @laggage_list.first.departure_country
        @lag_hash[:departure_state] = @laggage_list.first.departure_state
        @lag_hash[:departure_city] = @laggage_list.first.departure_city
        @lag_hash[:arrival_country] = @laggage_list.first.arrival_country
        @lag_hash[:arrival_state] = @laggage_list.first.arrival_state
        @lag_hash[:arrival_city] = @laggage_list.first.arrival_city
        @lag_hash[:description] = @laggage_list.first.try(:description).html_safe
        @lag_hash[:address] = @current_user&.laggage_address&.address || ""
        @p_details = @laggage_list.first.package_details
        image_arr = []
        @p_details.each do |i|
        image_hash={}
        image_hash[:package_content] = i.slice(:id,:package_content, :size, :weight)
        image_hash[:package_image] = i.images if i.images.first.package_image.url.present? rescue nil
        image_arr << image_hash 
        end
        @lag_hash[:package_details] = image_arr
        render :json => {:responseCode => 200, :responseMessage => 'Luggage View Details', :laggage_details => @lag_hash}
     
   end


    

  def carried_order_details
      @@laggage_list = Laggage.where(id: params[:laggage_id])
      @laggage_list = @@laggage_list
      PricingInformation.shipping_charges_show_to_traveller @laggage_list rescue []
      @arr = PricingInformation.shipping_charges_show_to_traveller @laggage_list    
      @laggage = [] 
      @arr.each do |lag|
      laggage = {
        "traveler_earning" => lag["traveller_earning"],
        "commission" => lag["admin_commission_from_traveller"],
        "tax" => lag["tax"],
        "total" => lag["total_price"]
        # "percentage_value" => lag
      } 
      @laggage << laggage
      end 
      
      render :json => {:responseCode => 200, :responseMessage => 'Carried Order Details' , :carried_order_details => @laggage.first}
   end 

   
  
  private
   
  def traveller_params
    params.require(:traveller).permit(:weight_upto,:weight_unit, :mode_of_travel, :departure_date,:departure_time, :departure_address, :departure_country, :departure_state, :departure_city, :departure_zip, :departure_meeting_address, :departure_meeting_country, :departure_meeting_state, :departure_meeting_city, :departure_meeting_zip, :arrival_date,:arrival_time ,:arrival_address, :arrival_country, :arrival_state, :arrival_city, :arrival_zip, :arrival_meeting_address, :arrival_meeting_country, :arrival_meeting_state, :arrival_meeting_city, :arrival_meeting_zip, :contact_person, :contact_phone, :contact_country_code, :last_date_to_recieve_item, :user_id)
  end

   

 end
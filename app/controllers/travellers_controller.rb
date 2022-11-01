class TravellersController < ApplicationController
layout "website"

  def index
  
  end

  def new
  	@traveller =  current_user.travellers.new
    @states = [] 
  end

  def create
    @traveller =  current_user.travellers.new(traveller_params)  
    if @traveller.save
      @@laggage_list = Laggage.laggage_request(@traveller)
      redirect_to request_list_travellers_path
    else
   	  render 'new'
    end
  end

  def country_change
    @country_id = Country.where(country_name: params[:country_name]).first.id
    @states = State.where(country_id: @country_id).pluck(:state_name)
    return render json: {state: @states}
  end


  def state_change
        @country_key = CS.countries.key(params[:country_name])
        @state_key = CS.states(@country_key).key(params[:state_name])
        @all_cities = CS.cities( @state_key, @country_key)
        return render json: {city: @all_cities}
     end
  
  def request_list
    if @@laggage_list.present?
    @laggage_list = @@laggage_list
      PricingInformation.shipping_charges_show_to_traveller @laggage_list rescue []
  
  @arr = PricingInformation.shipping_charges_show_to_traveller @laggage_list    
   else 
     flash[:notice] = "No sender found."
   end
  end 


  def order_details
  
  end

   def traveller_list
    @departure = params[:departure_address].split(",")
    @arrival = params[:arrival_address].split(",")
    @date = params[:departure_date]
    @traveller_date = Traveller.where('DATE(departure_date) = ?', @date)
    
   # @list = Traveller.where("departure_city ILIKE ? or departure_country ILIKE ? or (departure_city ILIKE ? and  departure_country ILIKE ? ) and arrival_city ILIKE ? or arrival_country ILIKE ? or (arrival_city ILIKE ? and arrival_country ILIKE ? )"   ,"#{@departure[0]}","#{@departure[1]}", "#{@departure[0]}","#{@departure[1]}", "#{@arrival[0]}", "#{@arrival[1]}", "#{@arrival[0]}","#{@arrival[1]}" )
  # @list = @traveller_date.where("departure_city ILIKE ? or departure_state ILIKE ? or (departure_city ILIKE ? and  departure_state ILIKE ? ) and arrival_city ILIKE ? or arrival_state ILIKE ? or (arrival_city ILIKE ? and arrival_state ILIKE ? )"   ,"#{@departure[0]}","#{@departure[1]}", "#{@departure[0]}","#{@departure[1]}", "#{@arrival[0]}", "#{@arrival[1]}", "#{@arrival[0]}","#{@arrival[1]}" )
   @list = @traveller_date.where("departure_city ILIKE ? or departure_state ILIKE ? or (departure_city ILIKE ? and  departure_state ILIKE ? ) and arrival_city ILIKE ? or arrival_state ILIKE ? or (arrival_city ILIKE ? and arrival_state ILIKE ? )"   ,"#{@departure[0]}","#{@departure[0]}", "#{@departure[0]}","#{@departure[1]}", "#{@arrival[0]}", "#{@arrival[1]}", "#{@arrival[0]}","#{@arrival[1]}" )

   #@list = @traveller_date.where("departure_city ILIKE ? or departure_state ILIKE ? or (departure_city ILIKE ? and  departure_state ILIKE ? ) and arrival_city ILIKE ? or arrival_state ILIKE ? or (arrival_city ILIKE ? and arrival_state ILIKE ? )"   ,"#{@departure[0]}","#{@departure[1]}", "#{@departure[0]}","#{@departure[1]}", "#{@arrival[0]}", "#{@arrival[1]}", "#{@arrival[0]}","#{@arrival[1]}" )

   end


# def traveller_list
#     @departure = params[:departure_address].split(',')[0]
#     @arrival = params[:arrival_address].split(',')[0]
#     @date = params[:departure_date]
#       a    = @date.split('/')  
#           @b =  a[0],a[1],a[2] 
#            @c = a[1], a[0],a[2]   
#      @list = Traveller.where('departure_city ILIKE ? and arrival_city ILIKE ? and departure_date.strftime("%m/%d/%Y") ILIKE ? ',  @departure, @arrival, @c )
#     #@list = Traveller.where('departure_city ILIKE ? and arrival_city ILIKE ?',  @departure, @arrival)
#    end

  private
   
  def traveller_params
    params.require(:traveller).permit(:weight_upto,:weight_unit, :mode_of_travel, :departure_date,:departure_time, :departure_address, :departure_country, :departure_state, :departure_city, :departure_zip, :departure_meeting_address, :departure_meeting_country, :departure_meeting_state, :departure_meeting_city, :departure_meeting_zip, :arrival_date,:arrival_time ,:arrival_address, :arrival_country, :arrival_state, :arrival_city, :arrival_zip, :arrival_meeting_address, :arrival_meeting_country, :arrival_meeting_state, :arrival_meeting_city, :arrival_meeting_zip, :contact_person, :contact_phone, :contact_country_code, :last_date_to_recieve_item, :user_id)
  end

end

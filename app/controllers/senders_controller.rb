class SendersController < ApplicationController
  layout "website"
  before_action :authenticate_user!
 
  def index
  end

  def new
    @states = []
    @laggage = Laggage.new
    package_detail = @laggage.package_details.build
    @image = package_detail.images.build
    @states1 = []
  end
   
   def edit
    @states = []
    @laggage = Laggage.find_by(id: params[:id])
    @package = @laggage.package_details
    @states = @laggage.departure_state.present? ? [@laggage.departure_state] : []
    @states1 = @laggage.arrival_state.present? ? [@laggage.arrival_state] : []
   end
   
   
 
   


 def update
    @laggage = Laggage.find_by(id: params[:id])
 if @laggage.update_attributes(laggage_params)
    @laggage.update(total_weight: @laggage.package_details.pluck(:weight).sum)
    @@user_laggage = @laggage
    @@list_of_travellers =  Traveller.traveller_request(@laggage)
    redirect_to sender_request_list_senders_path
    else
    flash[:error] = "Luggage unable to save."
     render 'new'
  end
 end






  def create
    @laggage =  current_user.laggages.new(laggage_params)  
    if @laggage.save
      @laggage.update(total_weight: @laggage.package_details.pluck(:weight).sum)
      @@user_laggage = @laggage
      @@list_of_travellers =  Traveller.traveller_request(@laggage)
      redirect_to sender_request_list_senders_path
    else
      render 'new'
    end
  end
 
  def sender_request_list
    if @@list_of_travellers.present?
      @list_of_travellers = @@list_of_travellers
      @user_laggage = @@user_laggage
      PricingInformation.shipping_charges @user_laggage
      @tax, @shipping_charges, @admin_commission_from_shipper,@total_price, @admin_commission_from_traveller, weight_unit = PricingInformation.shipping_charges @user_laggage
    else
      @user_laggage = @@user_laggage
      flash[:notice] = "No Traveller found."
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

  private

  def laggage_params
    params.require(:laggage).permit(:date, :time, :mode_of_travel, :departure_country, :departure_state, :departure_city, :arrival_country, :arrival_state, :arrival_city, :value_of_shipment, :description,
    :total_weight, package_details_attributes: [:id, :package_content,  :_destroy,:size, :weight_unit, :laggage_id, :weight , images_attributes: [:id,:package_image]])
  end

end


 
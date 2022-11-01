class Api::V1::SendersController < ApplicationController
before_action :find_user, :except=>[:all_country, :state, :city]



def all_country
a = []   
@country_names = Country.all.pluck(:country_name)
@country_names.each do |i|
h = {}
h["country_name"] = i
a << h
end
render json: {responseCode: 200, responseMessage: 'Country name list',
        country_name: a}


end


 def state
 	a = []
    @country_id = Country.where(country_name: params[:country_name]).first.id
    @states = State.where(country_id: @country_id).pluck(:state_name)
    @states.each do |i|
    h = {}
    h["state_name"] = i
     a << h
    end 
    render json: {responseCode: 200, responseMessage: 'State name list',
        state_name: a}
  end



def city
a = []
@country_key = CS.countries.key(params[:country_name])
@state_key = CS.states(@country_key).key(params[:state_name])
@all_cities = CS.cities( @state_key, @country_key)

@all_cities.each do |i|
    h = {}
    h["city_name"] = i
     a << h
    end 
    render json: {responseCode: 200, responseMessage: 'City name list',
        city_name: a}

end


 def sender_form

    # @laggage =  @current_user.laggages.new(laggage_params) 
    # params[:laggage][:package_details][:images_attributes] 
    @laggage =  @current_user.laggages.create(onlylaggage_params)
   if params[:laggage][:package_details_attributes].present?
    params[:laggage][:package_details_attributes].each do |i|
     @p = @laggage.package_details.create(package_content: i[:package_content] , size: i[:size], weight_unit: i[:weight_unit], laggage_id: @laggage.id, weight: i[:weight])
     if i[:images_attributes].present?
       i[:images_attributes].each do |j|
         @p.images.new(remote_package_image_url: j[:package_image]).save
       end
     end 
    end
   end 
    if @laggage.present?
      @laggage.update(total_weight: @laggage.package_details.pluck(:weight).sum)
      @@user_laggage = @laggage
      @@list_of_travellers =  Traveller.traveller_request(@laggage)
      @list_of_travellers = []
      @@list_of_travellers.each do |list|
       image = list.try(:user).try(:image).url rescue nil
       h2 = { "image" => image , "luggage_id" => @laggage.id}
      @list_of_traveller = list.slice(:id,:weight_unit, :contact_phone, :weight_upto,:mode_of_travel,:departure_date,:departure_country,:departure_state,:departure_city,:arrival_country,:arrival_state,:arrival_city,:arrival_date,:departure_meeting_address,:departure_meeting_country,:departure_meeting_state,:departure_meeting_city,:arrival_time, :departure_time).merge(h2)
      @list_of_travellers << @list_of_traveller
    end
      render json: {responseCode: 200, responseMessage: 'Traveller list',
        traveler_list: @list_of_travellers}
    else
      render 'new'
    end
  end





  # def create  
  #    @laggage =  current_user.laggages.new(laggage_params)
  #     if @laggage.save 
  #        @laggage.update(total_weight: @laggage.package_details.pluck(:weight).sum)
  #        @@user_laggage = @laggage      
  #        @@list_of_travellers =  Traveller.traveller_request(@laggage)       
  #        redirect_to sender_request_list_senders_path    
  #     else      
  #       render 'new' 
  #     end 
  # end




def package_image
if params[:package_image].present?
image = Cloudinary::Uploader.upload(params[:package_image],:resource_type => :auto)
render :json => {:responseCode  => 200,:responseMessage => "Image added successfuly.",:image => image["url"] }
end
end





  # def package_image
  # @p = PackageDetail.find_by(id: params[:package_detail_id])
  # @image = @p.images.new(package_image: params[:package_image]).save!
  # @images =  @p.images.last.package_image.metadata["url"] rescue nil
  # h2 = { "package_image" => @images}
  # render json: {responseCode: 200, responseMessage: 'Image created successfully',
  #       image: h2}
  # Image.where(package_detail_id: params[:package_detail_id]).delete_all
  # end
  









 def edit_luggage
    @states = []
    @laggage = Laggage.find_by(id: params[:laggage_id])
    @package = @laggage.package_details
    @states = @laggage.departure_state.present? ? [@laggage.departure_state] : []
    @states1 = @laggage.arrival_state.present? ? [@laggage.arrival_state] : []
   end



  def update_luggage
    @laggage = Laggage.find_by(id: params[:laggage][:id])
 if @laggage.update_attributes(laggage_params)
    @laggage.update(total_weight: @laggage.package_details.pluck(:weight).sum)
    @@user_laggage = @laggage
    @@list_of_travellers =  Traveller.traveller_request(@laggage)
    @list_of_travellers = []
    @@list_of_travellers.each do |list|

      @list_of_traveller = list.slice(:id,:weight_unit,:mode_of_travel,:departure_date,:departure_country,:departure_state,:departure_city,:arrival_country,:arrival_state,:arrival_city,:arrival_date,:departure_meeting_address,:departure_meeting_country,:departure_meeting_state,:departure_meeting_city,:arrival_time, :departure_time)
      @list_of_travellers << @list_of_traveller
    end
      render json: {responseCode: 200, responseMessage: 'Traveller list',
        city_name: @list_of_travellers}
    else
      render 'new'
    end
 end














 
  def sent_order_details
    @user_laggag = Laggage.where(id: params[:laggage_id])
    @user_laggage = @user_laggag.first 
    PricingInformation.shipping_charges @user_laggage
    @tax, @shipping_charges, @admin_commission_from_shipper,@total_price, @admin_commission_from_traveller, weight_unit = PricingInformation.shipping_charges @user_laggage 
  
       @laggage = {
     :shipping_charges => @shipping_charges,
    :commission =>   @admin_commission_from_shipper,
    :tax => @tax,
    :total => @total_price
  }
   
 render :json => {:responseCode => 200, :responseMessage => 'Sent Order Details' , :sent_order_details => @laggage}
  end


 private

  # def laggage_params
  #   params.require(:laggage).permit(:date, :time, :mode_of_travel, :departure_country, :departure_state, :departure_city, :arrival_country, :arrival_state, :arrival_city, :value_of_shipment, :description,
  #   :total_weight, package_details_attributes: [:id, :package_content,  :_destroy,:size, :weight_unit, :laggage_id, :weight])
  # end
def laggage_params
    params.require(:laggage).permit(:date, :time, :mode_of_travel, :departure_country, :departure_state, :departure_city, :arrival_country, :arrival_state, :arrival_city, :value_of_shipment, :description,
    :total_weight, package_details_attributes: [:id, :package_content,  :_destroy,:size, :weight_unit, :laggage_id, :weight , images_attributes: [:id,:package_image]])
  end
  def onlylaggage_params
    params.require(:laggage).permit(:date, :time, :mode_of_travel, :departure_country, :departure_state, :departure_city, :arrival_country, :arrival_state, :arrival_city, :value_of_shipment, :description,
    :total_weight)
  end

end

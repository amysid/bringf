class Admin::PaymentsController < Admin::BaseController

layout "admin"

  def index
    if params[:commit] == "Filter"
      search_condition = "%" + params[:country_id_cont]  + "%" rescue nil
      searched_countries_id = Country.where('country_name ILIKE ?', search_condition).pluck(:id)
      @pricing_informations = PricingInformation.where(:country_id => searched_countries_id)
    else
     @pricing_informations =  PricingInformation.all
    end
  end

  def new
  	@pricing_information = PricingInformation.new
  end

  def create
    @pricing_information = PricingInformation.new(pricing_information_params)
    if @pricing_information.save
      redirect_to admin_payments_path, notice: "Pricing information created successfully."
    else
    	redirect_to new_admin_payment_path, notice: "Something went wrong."
    end
  end
  
  def edit
    @pricing_information = PricingInformation.find(params[:id])
  end
  
  def update
    @pricing_information = PricingInformation.find(params[:id])
    if @pricing_information.update_attributes(pricing_information_params)
      flash[:notice] = "Payment setting updated successfully."
      redirect_to admin_payments_path
    else
      flash[:error] = "Something went wrong."
      redirect_to new_admin_payment_path
    end
  end

  def destroy
    @pricing_information = PricingInformation.find(params[:id])
    @pricing_information.destroy
    redirect_to admin_payments_path, notice: "Country deleted successfully."
  end

  private
  
  def pricing_information_params
    params.permit(:weight_from, :weight_to, :weight_from_unit, :weight_to_unit, :by_road_price_regional, :by_track_price_regional, :by_air_price_regional, :by_water_price_regional, :by_road_price_national, :by_track_price_national, :by_air_price_national, :by_water_price_national, :by_road_price_international, :by_track_price_international, :by_air_price_international, :by_water_price_international, :is_publish,:country_id )
  end

end

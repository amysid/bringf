class Admin::PricingInformationsController < Admin::BaseController

layout "admin"

  def index
    
    
    if params[:commit] == "Filter"
      search_condition = "%" + params[:country_id_cont]  + "%" rescue nil
      searched_countries_id = Country.where('country_name ILIKE ?', search_condition).pluck(:id)
      price_info = PricingInformation.where(:country_id => searched_countries_id)
      @pricing_informations = price_info.paginate(:page => params[:page], :per_page => 5).order('created_at desc')
    else
      @pricing_informations = PricingInformation.paginate(:page => params[:page], :per_page => 5).order('created_at desc')
    end
    country_id_in_price = PricingInformation.all.pluck(:country_id)
    @country_names = Country.where(id: country_id_in_price).pluck(:country_name)
  end

  def new
    @pricing_information = PricingInformation.new
  end

  def create
   @pricing_information = PricingInformation.new(pricing_information_params)
    if @pricing_information.save
      redirect_to admin_pricing_informations_path, notice: "Pricing information was created successfully"
    else
      flash[:notice]="Something wrong."
      render 'new'
    end
  end
  
  def edit
    @pricing_information = PricingInformation.find(params[:id])
    @unit = @pricing_information.weight_from_unit.present?  ? @pricing_information.weight_from_unit : ""
    @unit1 = @pricing_information.weight_to_unit.present?   ? @pricing_information.weight_to_unit  : ""
  end
  
  def update
    @pricing_information = PricingInformation.find(params[:id])
    if @pricing_information.update_attributes(pricing_information_params)
      flash[:notice] = "Pricing information setting updated successfully."
      redirect_to admin_pricing_informations_path
    else
      flash[:error] = "Something went wrong."
      redirect_to new_admin_pricing_information_path
    end
  end

  def destroy
    @pricing_information = PricingInformation.find(params[:id])
    @pricing_information.destroy
    redirect_to admin_pricing_informations_path, notice: "Pricing information deleted successfully"
  end

  def create_commission
    @commission = Commission.new(commission_params)
    if @commission.save
      redirect_to admin_pricing_informations_path, notice: "Commission  created successfully"
    else
      redirect_to admin_pricing_informations_path , notice: "Something went wrong."
    end
  end
  
  def find_weight_from_country
    cn = params[:country_name]
    country_id = Country.find_by(country_name: cn).try(:id)
    pi = PricingInformation.where(country_id: country_id)
    h = {}
    pi.map do |i|
      h[i.id] = i.weight_from.to_s + "" + i.weight_from_unit + " to " + i.weight_to.to_s + "" + i.weight_to_unit 
    end
    render json: {data: h}
  end

  private
  
  def pricing_information_params
    params.require(:pricing_information).permit(:weight_from, :weight_to, :weight_from_unit, :weight_to_unit, :country_name, :by_road_price_regional, :by_track_price_regional, :by_air_price_regional, :by_water_price_regional, :by_road_price_national, :by_track_price_national, :by_air_price_national, :by_water_price_national, :by_road_price_international, :by_track_price_international, :by_air_price_international, :by_water_price_international, :is_publish,:country_id )
  end
  
  def commission_params
    request = params[:commission][:country_id]
    country_id = Country.find_by(country_name: request).try(:id)
    params[:commission][:country_id] = country_id
    params.require(:commission).permit(:traveller_commission,:shipper_commission,:country_id, :pricing_information_id,:traveller_commission_type,:traveller_percentage,:traveller_fixed,:traveller_fixed,:shipper_commission_type, :shipper_percentage,:shipper_fixed)
  end
end

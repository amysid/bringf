require 'will_paginate/array'
class Admin::CountriesController < Admin::BaseController
  layout "admin"
  before_action :admin_authentication_user
  before_action :admin_authenticate_country, only: [:edit,:update, :create_state]

  skip_before_action :verify_authenticity_token

   



     def index
      params[:user] = "active"
       if params[:search].present?
          @search=true
          @countries = Country.where("country_name ILIKE ? "  , "%#{params[:search]}%").paginate(:page => params[:page], :per_page => 5).order('country_name')
       else
         @countries = Country.paginate(:page => params[:page], :per_page => 6).order('country_name')

      end
      respond_to do |format| 
        format.html
        format.js
      end
     end
 


  def destroy
   @country = Country.find(params[:id])
   @country.destroy
   redirect_to admin_countries_path, notice: "Country  deleted successfully"
  end


  def new
  end

  def create
    @country = Country.new(country_params)
    if @country.save
    	flash[:notice] = "Country created successfullly."
    	redirect_to admin_countries_path
    else
    	flash[:notice] = "Unable to create country."
      redirect_to new_admin_country_path
    end
  end

  def edit
    @states = @country.states
    country_key = CS.countries.find{|key, value| value[@country.country_name]}[0]
    @statess = CS.states(country_key)
  end
  
  def update
    if @country.update(country_params)
      flash[:notice] = "Country updated successfullly."
      redirect_to admin_countries_path
    else
      flash[:notice] = "Unable to update country."
      render 'edit'
    end

  end

  def create_state  
  state =  State.where(state_name: params[:state][:state_name], country_id: params[:state][:country_id])
  #state =  State.where(state_name: params[:state][:state_name])
    if state.present?
      flash[:notice] = "State already exists."
      redirect_to admin_countries_path
    else
      if @country.states.create(state_params)
        flash[:notice] = "State created successfullly."
        redirect_to admin_countries_path
      else
        flash[:notice] = "Unable to create state."
        redirect_to new_admin_country_path
      end
    end
  end

  def edit_state
    @state = @country.states.find(id: params[:id])
  end

  


   def update_state
    @state = State.find(params[:state_id])

         if @state.update_attributes(state_params)
            flash[:notice] = "State updated successfully."
            redirect_to admin_countries_path
         else
            flash[:error] = "Unable to save the State."
            redirect_to new_admin_country_path
        end
      end

def destroy_state
   @state = State.find(params[:id])
    @state.destroy
   redirect_to admin_countries_path, notice: "State  deleted successfully"
  end





  private
  def country_params
    params.require(:country).permit(:country_name, :continent, :iso_code, :tax_percentage, :published)
  end

  def admin_authenticate_country
    if params[:state].present?
      @country = Country.find( params[:state][:country_id])
    else
      @country = Country.find(params[:id])
    end
  end

  def state_params
    params.require(:state).permit(:state_name, :abbreviation, :country_id, :published)
  end
end

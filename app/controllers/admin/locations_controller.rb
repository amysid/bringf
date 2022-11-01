class Admin::LocationsController < Admin::BaseController
layout "admin"
before_action :admin_authentication_user
skip_before_action :verify_authenticity_token



   def index
      params[:user] = "active"
       if params[:search].present?
          @search=true
          @locations = Location.where("location_name ILIKE ?" , "%#{params[:search]}%").paginate(:page => params[:page], :per_page => 5)

       else
         @locations = Location.paginate(:page => params[:page], :per_page => 5).order('created_at desc')
      end
     end



  def new
    @location = Location.new
    @timing = @location.timings.build
    @states = []
  end


def create
	@location = Location.new(location_params)
  @location.save
  redirect_to admin_locations_path, notice: "Location  created successfully"
end



def edit
  @states = []
  @location = Location.find(params[:id])
  @timing = @location.timings
end





def update
        @location = Location.find(params[:id])

         if @location.update_attributes(location_params)
            @location.update_timings(params)
            flash[:notice] = "Location updated successfully."
            redirect_to admin_locations_path
         else
            flash[:error] = "User unable to save."
            redirect_to new_admin_location_path
        end
end





      def country_change
        country_id = params[:country_name].to_i
        @states = State.where(country_id: country_id).pluck(:state_name)
        return render json: {state: @states}
        
      end


def destroy
@location = Location.find(params[:id])
@location.destroy
redirect_to admin_locations_path, notice: "Location  deleted successfully"
end

private

def location_params
params.require(:location).permit(:location_name, :country_code, :country, :country_id, :phone_no, :address,:state, :city, :landmark, :zip, :publish, timings_attributes: [ :day, :is_open, :open_time, :close_time, :published, :am_or_pm_open_time, :am_or_pm_close_time])

end


end



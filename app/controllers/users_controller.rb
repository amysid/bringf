class UsersController < ApplicationController
	layout 'website'
  before_action :authenticate_user!, except: [:new, :create, :country_change, :state_change]
  def index
  end

  def new
    @user = User.new
    @states = []
  end
  


 
  def create
    binding.pry
  	 user = User.new(user_params)
          if user.save
            receiver_status = ReceiverStatus.find_by(receiver_email: user.email) rescue nil
            receiver_status.update_attributes(receiver_id: user.id, status: true)   if receiver_status.present?
            cookies.signed[:user_id] = user.id
            redirect_to  dashboards_path, notice: "User created successfully"
         else 
          flash[:error] = "Email already exist."
          redirect_to new_user_path
      end
    end


    def check_email
      params[:email] = params[:user].present? ? params[:user][:email] : nil
      @user= User.find_by(email: params[:email].downcase)
    if @user.present?
        render json: false
    else
        render json: :true
    end
end
  
  def edit
    @rr = Rating.where('sender_id = ?', current_user.id )
    @r  = @rr.sort_by{|e| e[:created_at]}.reverse


   #  tr = []
   #  r&.each do |i|
   #    us = User.find_by(id: i.receiver_id)
   #    tr << us
    
   # end
   # @tr = tr
    t = Transaction.joins(:laggage).select('laggages.id, laggages.laggage_status, laggages.date, laggages.departure_country, laggages.departure_state, laggages.departure_city, laggages.arrival_country, laggages.arrival_state, laggages.arrival_city, transactions.total_amount, laggages.arrival_state, laggages.total_weight, transactions.refund_status , transactions.id as transaction').group('laggages.id, transactions.id').where('laggages.user_id =?', current_user.id)
    @bank_detail = BankDetail.new
    @t =  t.paginate(:page => params[:page_1], :per_page => 5)
    @user = User.find_by(id: params[:id])
    @states = @user.state.present? ? [@user.state] : []
    @all_cities =  @user.city.present? ? [@user.city] : []
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update_attributes(user_params)
      redirect_to dashboards_path
      flash[:notice] = "Successfully updated"
    else
      flash[:alert] = @user.errors.full_messages
      redirect_to :back
    end
  end



def update_password
    @user = User.find_by(id: params[:id])

    unless (params[:new_password] == params[:confirm_password])
      flash[:error] = "Password and confirm password does't match."
      return redirect_to edit_user_path(@user)
    end
    if @user.authenticate(params[:old_password])
      @user.update_attributes(password: params[:new_password])
      cookies[:user_id] = nil
      cookies[:user_role] = nil
      flash[:notice] = "Password has sucessfully updated."
      redirect_to new_user_session_path
    else
      flash[:error] = "Password unable to update."
      redirect_to edit_user_path(@user)
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
  
    def bank_details
      @bank_detail = BankDetail.find_by(user_id: current_user.id)
        if @bank_detail.present? 
          @bank_detail.update_attributes(bank_params)
          flash[:notice] = "Bank details updated successfully."
          redirect_to dashboards_path
        else
          @bank_detail = current_user.build_bank_detail(bank_params)
          if @bank_detail.save
            flash[:notice] = "Bank details saved successfully."
            redirect_to dashboards_path 
          else
            flash[:error] = "Something went wrong."
            redirect_to edit_user_path
          end
        end
    end
    
     

     def rating
      @r = Rating.find_by(id: params[:user_id], sender_id: current_user.id, rating_status: false)
      @r.update!(star: params[:star], rating_status: true)
      flash[:notice] = "Rated successfully"
      redirect_to dashboards_path
     end

   private
    def user_params
      params.require(:user).permit(:first_name, :t_and_c, :last_name,:dob,:email,:password,:phone_no,:country_code,:address,:country,:state,:city,:zip,:image)
    end
   def bank_params
      params.require(:bank_detail).permit(:account_number, :holder_name, :spacial_code, :account_type, :user_id)
    end

end

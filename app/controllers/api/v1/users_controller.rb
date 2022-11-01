class Api::V1::UsersController < ApplicationController
   before_action :find_user, :except=>[:sign_up, :forget_password, :login]
  
   def sign_up
	  @user = User.new(user_params)
	  if @user.save
	    device = @user.devices.create(device_params) 
      UserMailer.registration_confirmation(@user).deliver!
      @selected = @user.slice(:id, :email, :access_token, :first_name, :last_name)
      render :json =>  {:responseCode => 200,:responseMessage => 'Registration successfully', :user => @selected}

    else
      render :json =>  {:responseCode => 500,:responseMessage => @user.errors.full_messages.first }	  
    end
  end
  
  


  def login
    @user = User.find_by(email: params[:user][:email]) 
  	if @user.present?
      return authentication_failed unless @user.authenticate(params[:user][:password])
      @device = Device.joins(:user).where("device_type=? and device_token=?", params[:device][:device_type], params[:device][:device_token])
      if @device.present?
         @device.destroy_all
      end
      @user.register_device params[:device][:device_type], params[:device][:device_token]
      @selected = @user.slice(:email, :first_name, :last_name, :dob, :phone_no, :country_code,:address,:country,:state,:city,:zip, :access_token)
      return render json:  {responseCode: 200,
        responseMessage: 'LoggedIn successfully.',
         user: @selected,
         device: @user.devices.last}
    else
      return render json: {responseCode: 500,
        responseMessage: 'Invalid credentials.' }
    end
  end
  


#    def logout
#     d = params[:device][:device_token]
#    device = Device.find_by(device_token: d)
#    @user = User.find_by(id: device.user_id) 
#   @user.devices.where(device_token: params[:device][:device_token])
#   render :json =>  {:responseCode => 200,:responseMessage => 'Successfully logged out.'}
# end

def logout
    @device = Device.where("device_token = ? AND user_id = ?", params[:device][:device_token], @current_user.id)
    render_message 200, 'logout successfully' if @device.destroy_all  
  end


  def view_profile
    @selected = @current_user.slice(:email, :first_name, :last_name, :dob, :phone_no, :country_code,:address,:country,:state,:city,:zip,:image)
    render json: {responseCode: 200, responseMessage: 'View profile successfully',
        user: @selected}
  end

def update_profile
    if @current_user.update_attributes(user_params)
       image = @current_user.image.metadata["url"] rescue nil
       h2 = { "image" => image}
      @selected1 = @current_user.slice(:email, :first_name, :last_name, :dob, :phone_no, :country_code,:address,:country,:state,:city,:zip)
       @selected = @selected1.merge(h2) 
      render json:  {responseCode: 200,
        responseMessage: 'update profile successfully' , user: @selected}
    else
      render_message 500, @current_user.errors.full_messages.first
    end
  end

  def forget_password
    @user = User.find_by(email: params[:user][:email])
    if @user.present?
       @new_password = User.generate_password 
       UserMailer.password_forget(@user, @new_password).deliver_now
       if @user.update(password: @new_password)
         render json: {responseCode: 200, responseMessage: 'Email has been send with new password'} 
       else
         return render json: {responseCode: 500, responseMessage: 'forget password not successfully'} 
       end
    else
      return render json: {responseCode: 500, responseMessage: 'forget password failed'}
    end 
  end

  def change_password
    return render json: {responseCode: 500,
    responseMessage: ' password incorrect' } unless @current_user.authenticate(params[:user][:old_password])
    if @current_user.password_reset(params[:user][:new_password], params[:user][:new_password])
      render_message 200, 'Password successfully updated.'  
    else
      render json: {responseCode: 500,
        responseMessage: 'change password failed',
        errors: @current_user.errors.full_messages.first}
    end
  end 









def confirm_email
    user = User.find_by_confirm_token(params[:id])
    if user
      user.email_activate
      # cookies.signed[:user_id] = user.id
      flash[:success] = "Welcome to the Bringitfast App! Your email has been confirmed.
      Please complete your profile."
      redirect_to root_url
    else
      flash[:error] = "Sorry. User does not exist"
      redirect_to root_url
    end
end

def location_address
  results = Geocoder.search([params[:lat], params[:long]])
  unless @current_user.laggage_address
    @current_user.laggage_address = LaggageAddress.new(lat: params[:lat], long: params[:long], address: results.first.address)  
    @current_user.save(validate: falses)
  end
    @current_user.laggage_address.update(lat: params[:lat], long: params[:long], address: results.first.address)
    render json: {responseCode: 200, address: results.first.address }
end



  private

  def authentication_failed
  	render json: {responseCode: 403, responseMessage: ('Please check your email/password.')}
  end
  
    def user_params
      params.require(:user).permit(:first_name, :t_and_c, :last_name,:dob,:email,:password,:phone_no,:country_code,:address,:country,:state,:city,:zip,:image)
    end
  

  def device_params
    params.require(:device).permit(:device_type, :device_token)
  end


end

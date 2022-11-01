class UserSessionsController < ApplicationController
layout "website"

 def index
 end
 

 def new
 end

 def create
 	 user = User.find_by(email: params[:email])
     if (user&.present? and user&.authenticate(params[:password]))
		   return redirect_to "/", alert: "You are currently blocked by admin." if (user.is_block == true)
		   
		   if params["remember-me"].present?
         cookies.permanent.signed[:user_id] = user.id
       else
			   cookies.signed[:user_id] = user.id
			 end
		 	
		 	session[:user_id] = user.id
      flash[:notice] = "You are successfully logged In."
      redirect_to  dashboards_path
    
    else
       render 'new'
       flash[:error] = "Invalid Email or Password"
    end
 end

def forget_password
  
    @user = User.find_by(email: params[:email])
    if @user.present?
       @new_password = User.generate_password 
       UserMailer.forget_email(@user, @new_password).deliver!
       if @user.update(password: @new_password)
         redirect_to new_user_session_path , notice: "Your password is successfully sent to your email."
       else
         redirect_to new_user_session_path , notice: "Something went wrong."
       end
    else
      redirect_to forget_password_user_sessions_path, notice: "Email address does not exist."
    end 
  end


 def destroy
    cookies.signed[:user_id] = nil if cookies.signed[:user_id].present?
    redirect_to '/'
  end

end

class Admin::SessionsController < Admin::BaseController
  
  layout "admin"
  def new
    if admin_user
      redirect_to admin_homes_path
    end
  end

  #for authenticate admin for login
  def create
  	user = AdminUser.find_by(email: params[:email])
    if (user && user.authenticate(params[:password]))
    	session[:admin_id] = user.id
      flash[:notice] = "You are successfully logged In."
      redirect_to  admin_homes_path
    else
      redirect_to new_admin_session_path
      flash[:error] = "Invalid Email or Password"
    end
  end


  def destroy
    session[:admin_id] = nil
    session[:role] = nil
    flash[:notice] = "You have successfully logged out."
    redirect_to new_admin_session_path
  end

def forget_password
    @admin_user = AdminUser.find_by(email: params[:email])
    if @admin_user.present?
       @new_password = AdminUser.generate_password 
       UserMailer.password_forget(@admin_user, @new_password).deliver!
       if @admin_user.update(password: @new_password)
         redirect_to new_admin_session_path , notice: "Your password is successfully sent to your email."
       else
         redirect_to new_admin_session_path , notice: "Something went wrong."
       end
    else
      redirect_to forget_password_admin_sessions_path, notice: "Email address does not exist."
    end 
  end

def update_password
     if current_user.authenticate(params[:current_password])
      if current_user.update(password: params[:new_password])
        flash[:notice] = "Password reset successfully."
        return redirect_to "/"
      else
        return render 'change_password'
      end
    else
      flash[:alert]  ="Current password mismatched"
      return render 'change_password' 
    end
  end

end




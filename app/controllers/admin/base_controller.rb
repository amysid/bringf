class Admin::BaseController < ApplicationController
  helper_method :admin_user

	def admin_user
		admin_user ||= AdminUser.find_by(id: session[:admin_id]) if session[:admin_id]
  end

  #for authenticate user
  def admin_authentication_user
    if admin_user
      
    else
      redirect_to new_admin_session_path
    end
  end
  

end

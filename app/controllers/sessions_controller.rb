class SessionsController < ApplicationController


def create	
		@user = User.find_by(email: params[:user][:email])
		if @user.present?
			auth_password= @user.valid_password?(params[:user][:password])
			if auth_password
				if @user.is_block == true
					flash[:notice] = "This User is blocked"
					redirect_to new_user_session_path
				end
			else
				flash[:notice] = "Please enter the correct password"
			end
		else
			flash[:notice] = "Please enter the correct email"
		end 
		super
	end
end

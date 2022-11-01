 class ApplicationController < ActionController::Base
   # protect_from_forgery with: :exception
    protect_from_forgery with: :exception, unless: -> { request.format.json? }

   helper_method :current_user
  
  def current_user
    
     current_user ||= User.find(cookies.signed[:user_id]) if cookies.signed[:user_id]
  end
  
  # def authentication_user
  #   if current_user
      
  #   else
  #     redirect_to new_user_path
  #   end
  # end

  def render_message code,message
    render :json => {:responseCode => code,:responseMessage => message}
  end
    
  def is_json?
    if request.format != :json
      render :json => {
        :responseCode => 400,
        :responseMessage => "The request must be json."
      }
    end
  end



def find_user
    if request.headers[:AUTHTOKEN].present?
      user_token = request.headers[:AUTHTOKEN]
      @current_user = User.find_by_access_token(user_token)
      unless @current_user
        render_message 500,"Oops! User not found."
    else
      render_message 500, "Sorry! You are not an authenticated user." unless @current_user
    end
    end
  end

  def authenticate_user!
   
    redirect_to '/user_sessions/new' unless current_user.present?
  end

 

end

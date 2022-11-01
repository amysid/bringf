class UserMailer < ApplicationMailer
	
default :from => "no-reply@domain.com"


  
  
  def registration_confirmation(user)
    @user = user
    mail(:to => user.email, :subject => "Registration Confirmation")
   end

	def password_forget admin_user, password
  	  @user = admin_user
      @user_email = admin_user.email
      @password = password
      mail(to: @user_email, subject: "Bring It Fast application-New password")
 
    end

    def forget_email user, password
    	
      @user = user
      @email= @user.email
      @password = password
      mail(to: @email, subject: 'Bring It Fast application-New password')
    end

    def laggage_transafer_confirmation current_user,  user_laggage, traveller
      @current_user = current_user
      @user_laggage = user_laggage
      @traveller_departure_meeting_address = traveller.departure_meeting_address
      @traveller_arrival_meeting_address = traveller.arrival_meeting_address
      @last_date_receive_item = traveller.last_date_to_recieve_item
      mail(:to => @current_user.email, :subject => "Luggage transaction confirmation")
    end

     def receiver_email receiver, user_laggage
     laggage =  user_laggage
     @sender = Laggage.find_by(id: laggage)
     @sender_state = @sender.arrival_state
     @sender_city = @sender.arrival_city
     @receiver = receiver.email
     mail(to: @receiver, subject: "Receiving confirmation.")
     end


     def new_receiver_email email, user_laggage
     laggage =  user_laggage
     @sender = Laggage.find_by(id: laggage)
     @sender_state = @sender.arrival_state
     @sender_city = @sender.arrival_city
     @email = email
     mail(to: @email, subject: "Please signup to receive the luggage.")
     end
     
     def send_subscription_info(subs_message,emails)
      @emails = emails
      @subscription_message = subs_message
      mail(:to=> @emails, :subject => "Contact Us.")
  end
end

class ContactMailer < ApplicationMailer
  
  def user_details contact
  	@contact = contact
    #mail(to: "ashmeet.kaur@mobiloittegroup.com", subject: "A user wants to contact with you.", contact: @contact)
    mail(to: "support@bringitfast.ca", subject: "A user wants to contact with you.", contact: @contact)

  end

end

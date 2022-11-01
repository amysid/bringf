class ContactsController < ApplicationController
  layout "website"

  def index
  end

  def new
  	@contact = ContactU.new
  end


  def create
    @contact = ContactU.new(contact_params)
    respond_to do |format|
      if verify_recaptcha(model: @contact) && @contact.save
        ContactMailer.user_details(@contact).deliver!
        if current_user.present?
        format.html {redirect_to dashboards_path, notice: 'Thankyou, we will contact you soon.' }
        else
        format.html {redirect_to welcomes_path, notice: 'Thankyou, we will contact you soon.' }
        end
      else
        format.html { render :new , notice: "Something went wrong."}
      end
    end
  end

  def contact_params
    params.require(:contact_u).permit(:name, :reason_for_contacting, :message, :email)
  end

end

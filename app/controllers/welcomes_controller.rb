class WelcomesController < ApplicationController
  layout "website"


  skip_before_action :verify_authenticity_token  
 def about_us
    # @about_us = Content.where(title: "About us")[0].try(:body)
 end  
  
 def privacy
 end

 def pricing
 end
 
  def faq
    @faqs = Faq.all
  end




 def newsletter
    params[:email] = params[:email].downcase
    @newsletter = Newsletter.find_by(email: params[:email])
    if @newsletter.blank?
      Newsletter.create!(email: params[:email],is_subscribed: true)
      flash[:success] = "Subscribed successfully."
      redirect_to welcomes_path
    elsif @newsletter.is_subscribed == true
      flash[:error] = "You already subscribed."
      redirect_to welcomes_path
     else
      @newsletter.update_attributes(is_subscribed: true)
      flash[:success] = "Subscribed successfully."
      redirect_to welcomes_path
    end 
  end





end

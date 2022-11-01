class Admin::JourneyrequestsController < Admin::BaseController
layout "admin"

  

  def index
    @carried_laggages =  Laggage.where('traveller_id IS NOT ? AND traveller_laggage_status  = ? ', nil, true).order('created_at desc')
    @sent_laggages1 =  Laggage.where('user_id IS NOT ? ', nil).order('created_at desc')
    @sent_laggages = @sent_laggages1.where.not(traveller_id: present?)  
    @received_laggages =  Laggage.where('receiver_id IS NOT ? AND Laggage_status = ? ', nil, true) 
  end

  def sort_order
    if params.keys[0] == "filt"
      carried_laggages =  Laggage.where('traveller_id IS NOT ? AND traveller_laggage_status  = ? ', nil, true)
      if params[:filt] == "By Date"
        @carried_laggages = carried_laggages.sort_by(&:date).reverse
      elsif params[:filt] == "By Weight"
        @carried_laggages =  carried_laggages.sort_by(&:total_weight).reverse
      else
        @carried_laggages =  carried_laggages.sort_by(&:value_of_shipment).reverse
      end
                   # @sent_laggages = sent_laggages.sort_by(&:total_weight).reverse

            @received_laggages =  Laggage.where('receiver_id IS NOT ? AND Laggage_status = ? ', nil, true) 

      respond_to do |format|
        format.js { render :index,received_laggages: @received_laggages, carried_laggages: @carried_laggages,   sent_laggages: @sent_laggages}
      end    
    elsif params.keys[0] == "filt1"
      sent_laggage =  Laggage.where('user_id IS NOT ? ', nil) 
      sent_laggages = sent_laggage.where.not(traveller_id: present?)
      if params[:filt1] == "By Date"
        @sent_laggages = sent_laggages.sort_by(&:date).reverse
      elsif params[:filt1] == "By Weight"
        @sent_laggages = sent_laggages.sort_by(&:total_weight).reverse
      else
        @sent_laggages = sent_laggages.sort_by(&:value_of_shipment).reverse
      end
      

      @received_laggages =  Laggage.where('receiver_id IS NOT ? AND Laggage_status = ? ', nil, true) 
      @carried_laggages =  Laggage.where('traveller_id IS NOT ? AND traveller_laggage_status  = ? ', nil, true)

      respond_to do |format|
        format.js { render :index,received_laggages: @received_laggages, carried_laggages: @carried_laggages,   sent_laggages: @sent_laggages}
      end     
    
    elsif params.keys[0] == "filt2"
            @received_laggages =  Laggage.where('receiver_id IS NOT ? AND Laggage_status = ? ', nil, true) 
      if params[:filt] == "By Date"
        @received_laggages =  received_laggages.sort_by(&:date).reverse
      elsif params[:filt] == "By Weight"
        @received_laggages =  received_laggages.sort_by(&:total_weight).reverse
      else
        @received_laggages =  received_laggages.sort_by(&:value_of_shipment).reverse
      end
            @carried_laggages =  Laggage.where('traveller_id IS NOT ? AND traveller_laggage_status  = ? ', nil, true)
                   @sent_laggages = sent_laggages.sort_by(&:total_weight).reverse

      respond_to do |format|
        format.js { render :index,received_laggages: @received_laggages, carried_laggages: @carried_laggages,   sent_laggages: @sent_laggages}
      end  
   
    end
  end


 end



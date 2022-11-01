require 'will_paginate/array'
class DashboardsController < ApplicationController
	layout "website"

  def index
    # carried
    tr = Traveller.where(user_id: current_user.id).pluck(:id) rescue nil
    carried = []
    
    tr&.each do |i| 
      laggage = Laggage.where(traveller_id: i, traveller_laggage_status: false) rescue nil
      carried << laggage
    
   end
      carrie = carried.flatten!
      @carried = carrie.sort_by{|e| e[:created_at]}.reverse rescue nil
      traveller = Traveller.where(user_id: current_user.id).pluck(:id) rescue nil
      carried_laggages = []
     tr&.each do |i| 
      laggage = Laggage.where(traveller_id: i, traveller_laggage_status: true)
      carried_laggages << laggage
     end
     @carried_lag = carried_laggages.flatten!
     @carried_laggages = @carried_lag.sort_by{|e| e[:created_at]}.reverse  rescue nil
     @@carried_laggages = @carried_laggages
       # carried end
     
   # sent  
    @sent_lagg1 =  Laggage.where('user_id = ? ', current_user.id).limit(5) 
       @sent_lagg = @sent_lagg1.where.not(traveller_id: present?)
        @sent_laggages =  @sent_lagg.sort_by{|e| e[:created_at]}.reverse rescue nil
       # sent end
       
       # Received 
     r = ReceiverStatus.where(receiver_email: current_user.email) rescue nil
     @a = []
      r&.each do |i|
       laggage_id =  i.laggage_id
       # luggage = Laggage.find_by(id: laggage_id,laggage_status: false)
        # after receiver cancel process
       luggage = Laggage.find_by(id: laggage_id,laggage_status: false)
       @a << luggage
       @a.compact!
       @a = @a.sort_by{|e| e[:created_at]}.reverse rescue nil
     end
       @received_lagg = Laggage.where(receiver_id: current_user.id, laggage_status: true ).limit(5) 
       @received_laggages = @received_lagg.sort_by{|e| e[:created_at]}.reverse rescue nil
       @@received_laggages = @received_laggages
        # received end
  
  end
  
  def new
  end

  def create
  end


  def sort_by_filter
    if params.keys[0] == "carried_filter"
        if params[:carried_filter] == "By Date"
          # @carried_laggages = @@carried_laggages.order('date desc').limit(5)
          @carried_laggages =  @@carried_laggages.flatten.sort_by(&:date).reverse 
        elsif params[:carried_filter] == "By Weight"
          # @carried_laggages =  @@carried_laggages.order('total_weight desc').limit(5)
          @carried_laggages =  @@carried_laggages.flatten.sort_by(&:total_weight).reverse
        else
          # @carried_laggages =  @@carried_laggages.order('value_of_shipment desc').limit(5) 
          @carried_laggages = @@carried_laggages.flatten.sort_by(&:value_of_shipment).reverse
        end
           puts "=========+#{@carried_laggages.inspect}"
         @sent_laggage = Laggage.where('user_id = ?', current_user.id)#.paginate(:page => params[:page_2], :per_page => 3)
         @sent_laggages = @sent_laggage.where.not(traveller_id: present?)
         @received_laggages = @@received_laggages#.paginate(:page => params[:page_3], :per_page => 3)
         respond_to do |format|  
           format.js { render :index,sent_laggages: @sent_laggages, received_laggages: @received_laggages,  carried_laggages: @carried_laggages,  layout: false}
         end    
    elsif params.keys[0] == "sent_filter"
      sent_laggage =  Laggage.where('user_id = ?', current_user.id)
      sent_laggages = sent_laggage.where.not(traveller_id: present?)
      if params[:sent_filter] == "By Date"
          @sent_laggages = sent_laggages.order('date desc')#.paginate(:page => params[:page_2], :per_page => 3)
      elsif params[:sent_filter] == "By Weight"
        puts "=========+#{@carried_laggages.inspect}"
        @sent_laggages =  sent_laggages.order('total_weight desc')#.paginate(:page => params[:page_2], :per_page => 3)
      else
        @sent_laggages =  sent_laggages.order('value_of_shipment desc')#.paginate(:page => params[:page_2], :per_page => 3)
      end
      @carried_laggages = @@carried_laggages
      @received_laggages = @@received_laggages#.paginate(:page => params[:page_3], :per_page => 3)
      respond_to do |format|  
        format.js { render :index,sent_laggages: @sent_laggages, received_laggages: @received_laggages,  carried_laggages: @carried_laggages,  layout: false}
      end 
    elsif params.keys[0] == "received_filter"
      received_laggages = @@received_laggages
      if params[:received_filter] == "By Date"
        @received_laggages = received_laggages.sort_by(&:date).reverse#.paginate(:page => params[:page], :per_page => 5) 
      elsif params[:received_filter] == "By Weight"
        @received_laggages =  received_laggages.sort_by(&:total_weight).reverse#.paginate(:page => params[:page], :per_page => 5)
      else
       @received_laggages =  received_laggages.sort_by(&:value_of_shipment).reverse#.paginate(:page => params[:page], :per_page => 5)
      end
      @carried_laggages = @@carried_laggages
       @sent_laggages = Laggage.where('user_id = ? ', current_user.id)#.paginate(:page => params[:page_2], :per_page => 3)
        p "-------------"
       respond_to do |format|  
        format.js { render :index,sent_laggages: @sent_laggages, received_laggages: @received_laggages,  carried_laggages: @carried_laggages,  layout: false}
      end 
     end
  end

  def receiver_deliver_status
    @l = Laggage.find(params[:id])
    @l.update(status: 2,  arrival_date: Date.today)
    t = Traveller.find_by(id: @l.traveller_id)
    receiver = User.find_by(id: t.user_id)
    sender = @l.user_id
    Rating.create!(sender_id: sender, receiver_id: receiver.id, laggage_id: @l.id)
    flash[:notice] = "Luggage #{@l.status? ? 'delivered' :  'deliver' } successfully "
    redirect_to dashboards_path
  end
    
  
  

  #for accept request by receiver and reject request by receiver
      def accept
        @a = Laggage.find(params[:id])
        # payment = @a.payment
        # shipping_charges = (payment.total_amount - payment.country_tax - payment.admin_earning_by_shipper) rescue nil
        # country_id = Country.find_by(country_name: @a.departure_country).id rescue nil
        # pi =  PricingInformation.where(country_id: country_id) rescue nil
        # exact_pi = pi.where('weight_from <= ? and weight_to >= ?', @a.total_weight, @a.total_weight) rescue []
        # commission = exact_pi.first.commissions rescue nil
        # if commission.first.traveller_commission_type = "traveller_fixed"
        #   admin_earning_by_traveller = commission.first.traveller_commission
        # else
        #   percentage = commission.first.traveller_commission
        #   admin_earning_by_traveller = ((percentage / 100 ) * shipping_charges).round(2) rescue nil
        # end
        # total_amount = (shipping_charges - payment.country_tax - admin_earning_by_traveller ) rescue nil
        # transfer money to traveller
        tran = Transaction.find_by(laggage_id: params[:id])
        tran.update(status: true)
        # @a.update(laggage_status: true, status: 2, receiver_id: current_user.id, arrival_date: Date.today)
        @a.update(laggage_status: true, receiver_id: current_user.id)
        flash[:notice] = "Luggage #{@a.laggage_status? ? 'accepted' :  'accept' } successfully "
        redirect_to dashboards_path
      end

      
      def cancel_request
      @a = Laggage.find(params[:laggage_id])
      @a.update(status: 3)
      redirect_to dashboards_path
      end



      def accept_carry_request
       @a = Laggage.find(params[:id])
       @a.update(traveller_laggage_status: true)
       flash[:notice] = "Luggage #{@a.laggage_status? ? 'accepted' :  'accept' } successfully "
       redirect_to dashboards_path
      end

end

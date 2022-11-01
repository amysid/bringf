class Api::V1::DashboardsController < ApplicationController
 

before_action :find_user


def carried_laggage_list
    # carried
    tr = Traveller.where(user_id: @current_user.id).pluck(:id) rescue nil
    carried = []
    
    tr&.each do |i| 
      laggage = Laggage.where(traveller_id: i, traveller_laggage_status: false) rescue nil
      carried << laggage
    
    end
      carrie = carried.flatten!
      @carried = carrie.sort_by{|e| e[:created_at]}.reverse rescue nil
      traveller = Traveller.where(user_id: @current_user.id).pluck(:id) rescue nil
      carried_laggages = []
     tr&.each do |i| 
      laggage = Laggage.where(traveller_id: i, traveller_laggage_status: true)
      carried_laggages << laggage
     end
     @carried_lag = carried_laggages.flatten!
     @carried_laggages = @carried_lag.sort_by{|e| e[:created_at]}.reverse  rescue nil
     @@carried_laggages = @carried_laggages
     unit = @carried_laggages.first.package_details.first.weight_unit  rescue nil
     @carried_laggages = []
     @@carried_laggages&.each do |carried|

     carried_laggages =  carried.slice(:id,:date, :departure_country, :departure_state, :departure_city, :arrival_country, :arrival_state,:arrival_city, :total_weight).as_json.merge("weight_unit" => unit) rescue nil
      @carried_laggages  << carried_laggages
    end
     render :json =>  {:responseCode => 200,:responseMessage => 'Carried luggage List', :carried_laggages => @carried_laggages}
       # carried end
 
  end
   

    def received_laggage_list
      # Received 
     r = ReceiverStatus.where(receiver_email: @current_user.email) rescue nil
     @a = []
      r&.each do |i|
       laggage_id =  i.laggage_id
        # after receiver cancel process
       luggage = Laggage.find_by(id: laggage_id,laggage_status: false)
       @a << luggage
       @a.compact!
       @a = @a.sort_by{|e| e[:created_at]}.reverse rescue nil
     end
       @received_lagg = Laggage.where(receiver_id: @current_user.id, laggage_status: true ).limit(5) 
       @received_laggages = @received_lagg.sort_by{|e| e[:created_at]}.reverse rescue nil
       @@received_laggages = @received_laggages
       unit = @received_laggages.first.package_details.first.weight_unit rescue nil
       @received_laggages = []
       @@received_laggages.each do |receive|
       receive_laggage = receive.slice(:id, :date, :departure_country, :departure_state,:departure_city, :arrival_country, :arrival_city, :arrival_state, :total_weight).as_json.merge("weight_unit" => unit)
       @received_laggages << receive_laggage
     end
       render :json => {:responseCode => 200, :responseMessage => 'Received Laggage List', :received_laggages =>  @received_laggages}
      # received end
  
    end


    def sent_laggage_list
      # sent  
      @sent_lagg1 =  Laggage.where('user_id = ? ', @current_user.id).limit(5) 
      @sent_lagg = @sent_lagg1.where.not(traveller_id: present?)
      @sent_laggages =  @sent_lagg.sort_by{|e| e[:created_at]}.reverse rescue nil
       unit = @sent_laggages.first.package_details.first.weight_unit  rescue nil
       sent_laggages = []
      @sent_laggages.each do |sent|
      
     sent_laggage = sent.slice(:id, :date, :departure_country, :departure_state,:departure_city, :arrival_country, :arrival_city, :arrival_state, :total_weight).as_json.merge("weight_unit" => unit)
       sent_laggages << sent_laggage
      end
      render :json => {:responseCode => 200, :responseMessage => 'Sent Laggage List', :sent_laggages => sent_laggages}
      # sent end
    end




    def pending_carry_request_list
       tr = Traveller.where(user_id: @current_user.id).pluck(:id) rescue nil
       carried = []
    
        tr&.each do |i| 
          laggage = Laggage.where(traveller_id: i, traveller_laggage_status: false) rescue nil
          carried << laggage
        
        end
      carrie = carried.flatten!
      @carried = carrie.sort_by{|e| e[:created_at]}.reverse rescue nil
      carried = []
      @carried&.each do |i|
      @selected = i.slice(:id,:departure_country, :departure_state, :departure_city, :arrival_country, :arrival_state, :arrival_city, :date , :total_weight )
     carried << @selected
   end
      render :json => {:responseCode => 200, :responseMessage => 'Pending Carry Request List', :pending_carry_request_list => carried}
    end

    def pending_receive_request_list
      r = ReceiverStatus.where(receiver_email: @current_user.email) rescue nil
       @a = []
        r&.each do |i|
        laggage_id =  i.laggage_id
        # after receiver cancel process
        luggage = Laggage.find_by(id: laggage_id,laggage_status: false)
        @a << luggage
        end
        @a.compact!
        @a = @a.sort_by{|e| e[:created_at]}.reverse rescue nil
        received = []
      @a&.each do |i|
      @selected = i.slice(:id,:departure_country, :departure_state, :departure_city, :arrival_country, :arrival_state, :arrival_city, :date , :total_weight )
     received << @selected
   end
        render :json => {:responseCode => 200, :responseMessage => 'Pending Receive Request List', :pending_receive_request_list => received}
    end

   
      def accept_carry_request
       @a = Laggage.find(params[:laggage_id])
       @a.update(traveller_laggage_status: true)
       flash[:notice] = "Luggage #{@a.laggage_status? ? 'accepted' :  'accepted' } successfully "
       render :json => {:responseCode => 200, :responseMessage => flash[:notice]}
      end


      def accept_receive_request
        @a = Laggage.find(params[:laggage_id])
        tran = Transaction.find_by(laggage_id: params[:laggage_id])
        tran.update(status: true)
        @a.update(laggage_status: true, receiver_id: @current_user.id)
        flash[:notice] = "Luggage #{@a.laggage_status? ? 'accepted' :  'accepted' } successfully "
        render :json => {:responseCode => 200, :responseMessage => flash[:notice]}
      end

 

end

      
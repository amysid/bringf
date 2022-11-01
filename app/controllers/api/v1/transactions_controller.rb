class Api::V1::TransactionsController < ApplicationController

before_action :find_user



 



 def all_transaction
  @t = Transaction.joins(:laggage).select('laggages.id, laggages.laggage_status, laggages.date, laggages.departure_country, laggages.departure_state, laggages.departure_city, laggages.arrival_country, laggages.arrival_state, laggages.arrival_city, transactions.total_amount, laggages.arrival_state, laggages.total_weight, transactions.refund_status , transactions.id as transaction').group('laggages.id, transactions.id').where('laggages.user_id =?', @current_user.id)
    transaction = []
    @t.each do |t|
    tran_hash = {}
     tran_hash[:laggage_id] =t.id
     tran_hash[:departure_country] =t.departure_country
     tran_hash[:departure_state] = t.departure_state
     tran_hash[:departure_city] =t.departure_city
     tran_hash[:arrival_country]= t.arrival_country
     tran_hash[:arrival_state] =t.arrival_state
     tran_hash[:arrival_city]  = t.arrival_city
     tran_hash[:date]= t.date
     tran_hash[:weight]= t.total_weight
     tran_hash[:amount]= t.total_amount
   transaction << tran_hash
 end

  render json: {responseCode: 200, responseMessage: 'Transaction list',
        transaction_list: transaction}
 end






def create_transaction
    payment_status = params[:stripeToken].present? ? true : false 
    traveller_id = params[:traveller_id]
    traveller = Traveller.find_by(id: traveller_id)
    @@user_laggage = params[:user_laggage_id]
    @user_laggage = Laggage.find_by(id: params[:user_laggage_id])
    shipping_charges = params[:shipping_charges].to_f
    PricingInformation.shipping_charges @user_laggage
      @tax, @shipping_charges, @admin_commission_from_shipper,@total_price, @admin_commission_from_traveller, weight_unit = PricingInformation.shipping_charges @user_laggage
    admin_commission_from_shipper = @admin_commission_from_shipper.to_f
     admin_commission_from_traveller = @admin_commission_from_traveller.to_f
    country_tax = params[:country_tax].to_f
    total_price = params[:total_price].to_f
     if payment_status == true
      success,response = Transaction.make_payment_to_admin(params[:stripeToken], total_price)
     if success
        Transaction.create!(name: @current_user.first_name, email: @current_user.email, laggage_id:  @@user_laggage, date: Date.current, total_amount: total_price, country_tax: country_tax, admin_earning_by_shipper: admin_commission_from_shipper,admin_earning_by_traveller: admin_commission_from_traveller, payment_response: response.to_json, stripe_transaction_id: response.id)
        UserMailer.laggage_transafer_confirmation(@current_user, @@user_laggage, traveller).deliver_now 
        TransferJob.perform_later(@current_user) 
         @lag = Laggage.find_by(id: @@user_laggage)
         @lag.update(traveller_id: traveller_id)
        flash[:success] = "Transaction  successfully."
        # redirect_to confirm_transaction_path(id: traveller_id)
        render json: {responseCode: 200, responseMessage: flash[:success]}

      else
        flash[:error] = "Transaction unsuccess."
      end
    end 
  end


   def confirm_transaction
      @id = params[:user_laggage]
   end


    def create_receiver
      @user_laggage = params[:laggage_id]
      @email = params[:email]
        @receiver = User.find_by(email: @email)
       if @receiver.present?
        ReceiverStatus.create(sender_id: @current_user.id, receiver_email: @email, receiver_id: @receiver.id, laggage_id: @user_laggage)
         
         UserMailer.receiver_email(@receiver, @user_laggage).deliver_now
       else
         ReceiverStatus.create(sender_id: @current_user.id, receiver_email: @email, laggage_id: @user_laggage)
         UserMailer.new_receiver_email(@email, @user_laggage).deliver_now
       end
       # redirect_to dashboards_path, notice: "Email sent successfully"
       render json: {responseCode: 200, responseMessage: "Email sent successfully"}
    end

    end

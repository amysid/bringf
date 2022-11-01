class TransactionsController < ApplicationController
  layout "website"
  before_action :authenticate_user!
  
  def index
  end

  def book_transaction
    @date = params[:date].to_date
    @user = User.find_by(id: params[:id])
  end

  def create_transaction
    payment_status = params[:stripeToken].present? ? true : false 
    traveller_id = params[:traveller_id]
    traveller = Traveller.find_by(id: traveller_id)
    @@user_laggage = params[:user_laggage_id]
    shipping_charges = params[:shipping_charges].to_f
    admin_commission_from_shipper = params[:admin_commission_from_shipper].to_f
     admin_commission_from_traveller = params[:admin_commission_from_traveller].to_f
    country_tax = params[:country_tax].to_f
    total_price = params[:total_price].to_f
 
    if payment_status == true
      success,response = Transaction.make_payment_to_admin(params[:stripeToken], total_price)
     if success
        Transaction.create!(name: current_user.first_name, email: current_user.email, laggage_id:  @@user_laggage, date: Date.current, total_amount: total_price, country_tax: country_tax, admin_earning_by_shipper: admin_commission_from_shipper,admin_earning_by_traveller: admin_commission_from_traveller, payment_response: response.to_json, stripe_transaction_id: response.id)
        UserMailer.laggage_transafer_confirmation(current_user, @@user_laggage, traveller).deliver_now 
         @lag = Laggage.find_by(id: @@user_laggage)
         @lag.update(traveller_id: traveller_id)
        flash[:success] = "Transaction made successfully."
        redirect_to confirm_transaction_path(id: traveller_id)
      else
        flash[:error] = "Transaction unsuccess."
      end
    end 
  end


   def confirm_transaction
      @id = params[:user_laggage]
   end


    def create_receiver
    	@@user_laggage
    	@email = params[:email]
        @receiver = User.find_by(email: @email)
       if @receiver.present?
       	ReceiverStatus.create(sender_id: current_user.id, receiver_email: @email, receiver_id: @receiver.id, laggage_id: @@user_laggage)
       	 
         UserMailer.receiver_email(@receiver, @@user_laggage).deliver_now
       else
       	 ReceiverStatus.create(sender_id: current_user.id, receiver_email: @email, laggage_id: @@user_laggage)
       	 UserMailer.new_receiver_email(@email, @@user_laggage).deliver_now
       end
       redirect_to dashboards_path, notice: "Email sent successfully"
    end
 
  
    def cancel_transaction
    amount =  params[:amount].to_f
    laggage_id = params[:laggage_id]
    deduction = (amount*10)/100
    refund_amount = (amount - deduction).to_i rescue nil
    laggage = Laggage.find_by(id: laggage_id)
    @transaction = Transaction.where(laggage_id: laggage_id)
    @transaction.update(refund_status: true, status: 2)
    a = JSON.parse(Transaction.where(laggage_id: laggage_id).first.payment_response)
    key   = a["id"]
    begin
    p "-----------begin---"
      refund = Stripe::Refund.create({
      :charge => key,
      :amount => refund_amount*100,
      })
    p "---------refund----#{refund.inspect}---"

    # return true,refund
     flash[:success] = "successfully refunded"
     return redirect_to dashboards_path
    rescue => e
    # return false,e.message
    flash[:error] = e.message
    return redirect_to dashboards_path
    end
    

   end





end





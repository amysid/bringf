class Admin::TransactionsController < Admin::BaseController
layout "admin"

  def index
    #@transactions =  Transaction.joins(:laggage).select('laggages.id as laggage_id, transactions.id, transactions.email, transactions.name, transactions.date, transactions.total_amount, transactions.admin_earning_by_shipper, transactions.admin_earning_by_traveller, transactions.country_tax ').where('laggages.laggage_status = ?', true)
      @transactions =  Transaction.joins(:laggage).select('laggages.id as laggage_id, transactions.id, transactions.email, transactions.name, transactions.date, transactions.total_amount, transactions.admin_earning_by_shipper, transactions.admin_earning_by_traveller,transactions.created_at, transactions.country_tax ').order('created_at desc')

  end

  def show
    @laggage = Laggage.find_by(id: params[:laggage_id]) rescue nil
    travel = @laggage.traveller_id rescue nil
    @user = Traveller.find_by(id: travel).user rescue nil
  end

end

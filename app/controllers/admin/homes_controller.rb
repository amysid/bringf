class Admin::HomesController < Admin::BaseController
  layout "admin"
  before_action :admin_authentication_user
  
  def index
    if params["country_name"].present?
      sql = Laggage.joins(:payment).select('laggages.departure_state, (transactions.total_amount) as total').where("laggages.departure_country = ? and transactions.status = ?", params["country_name"], true)
      a = []
      sql.each do |s|
        h = {}
        h["country_name"] =  s["departure_state"]
        h["total"] = s["total"]
        a << h
      end
      hash = {}
      a.each do |var|
        key = var["country_name"]
        value = var["total"]
        hash[key] = value
      end
      @hash = hash
      respond_to do |format|
        format.js { render :index, hash: @hash }
      end 
    end
    
    if params['from_date'].present? && params['to_date'].present?
      sql = Transaction.where('date >= ? and date <= ? and status = ?', params['from_date'], params['to_date'], true)
      a = []
      sql.each do |i|
        h = {}
        h['total_amount'] = i['total_amount']
        h['created_at'] = i['created_at']
        a << h
      end  
      hash1 ={}
      a.each do |var|
        key = var['created_at']
        value = var["total_amount"]
        hash1[key] = value
      end
      @hash1 = hash1
    end
    respond_to do |format|
      format.html
      format.js { render :index, hash1: @hash1 }
    end 
    @top_shippers = User.joins(laggages: :payment).select('transactions.total_amount, users.email').where('transactions.status = true').order('transactions.total_amount desc').limit(5) rescue nil
  end

end


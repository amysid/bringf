class Transaction < ApplicationRecord
  before_save :add_country
  belongs_to :laggage
 
  def add_country
    self.country_id =Country.find_by(country_name: self.laggage.departure_country).try(:id)
  end
  
  def self.country_graph
    sql = Laggage.joins(:payment).select('laggages.departure_country,sum(transactions.admin_earning_by_traveller + transactions.admin_earning_by_shipper) as total ').group("laggages.departure_country, transactions.status").having('transactions.status=true')
    a = []
    sql.each do |s|
      h = {}
      h["country_name"] =  s["departure_country"]
      h["total"] = s["total"]
      a << h
    end
    hash = {}
    a.each do |var|
      key = var["country_name"]
      value = var["total"]
      hash[key] = value
    end
    return hash
  end
  

  def self.country_revenue
    sql = Laggage.joins(:payment).select('laggages.departure_country, sum(transactions.total_amount) as total').group("laggages.departure_country, transactions.status").having('transactions.status=true')
      a = []
    sql.each do |s|
      h = {}
      h["country_name"] =  s["departure_country"]
      h["total"] = s["total"]
      a << h
    end
    hash = {}
    a.each do |var|
      key = var["country_name"]
      value = var["total"]
      hash[key] = value
    end
    return hash
  end

  def self.admin_earning_by_traveller
    a = Transaction.where(status: true).sum(:admin_earning_by_traveller) rescue nil
    h = {}
    h["Traveller profit"] = a
    return h
  end
  
  def self.admin_earning_by_shipper
  	a = Transaction.where(status: true).sum(:admin_earning_by_shipper) rescue nil
    h = {}
    h["Shipper profit"] = a
    return h
  end
  
  def self.total_profit
    a =  Transaction.where(status: true).sum(:admin_earning_by_shipper) +  Transaction.where(status: true).sum(:admin_earning_by_traveller) rescue nil
    h = {}
    h["total profit"] = a
    return h
  end

  def self.total_revenue
   a = Transaction.where(status: true).sum(:total_amount) rescue nil
    h = {}
    h["total revenue"] = a
    return h
  end

  def self.shipper_registrations
    sql = Laggage.joins(:user).select('users.id, laggages.created_at').uniq rescue []
    a = []
    sql.each do |s|
      h = {}
      h["created_at"] = s["created_at"]
      h["id"] =  s["id"]
      a << h
    end
    hash = {}
    a.each do |var|
      key = var["created_at"]
      value = var["id"]
      hash[key] = value
    end
    return hash
  end
  
  def self.revenue_shipper_data
    # a = Transaction.where(status: true).sum(:admin_earning_by_shipper) rescue nil
    a = Transaction.all.sum(:admin_earning_by_shipper) + Transaction.all.sum(:country_tax) rescue nil
    return a
  end
 
  def self.revenue_traveller_data
    # a = Transaction.where(status: true).sum(:admin_earning_by_traveller) rescue nil
    a = Transaction.all.sum(:admin_earning_by_traveller) + Transaction.all.sum(:country_tax) rescue nil
    return a
  end 
  
  def self.revenue_total_data
    # a = (Transaction.where(status: true).sum(:admin_earning_by_traveller) + Transaction.where(status: true).sum(:admin_earning_by_shipper) ) rescue nil
    # a = (Transaction.all.sum(:admin_earning_by_traveller)  + Transaction.all.sum(:admin_earning_by_shipper) ) rescue nil
    a = (Transaction.all.sum(:admin_earning_by_traveller) + Transaction.all.sum(:country_tax))  + (Transaction.all.sum(:admin_earning_by_shipper) + Transaction.all.sum(:country_tax)) rescue nil

    return a
  end 

  #payment to admin
  def self.make_payment_to_admin token,total_price
    total_price  = (total_price * 100).to_i
    p "--------token-------#{token.inspect}--"
    p "-------------#{total_price.inspect}--------"
    begin
    p "-----------begin---"
    response = Stripe::Charge.create(
    :amount => total_price,
    :currency => "usd",
    :description => "Example charge",
    :capture => false,
    :source => token,
    )
    response.capture
    p "---------response----#{response.inspect}---"
   return true,response
   rescue => e
   return false,e.message
   end
  end

end

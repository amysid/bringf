class Laggage < ApplicationRecord
 # before_create :add_weight_to_total_weight
  # enum status: [:requested, :carried, :received]
  # for request cancel by receiver
  enum status: [:requested, :carried, :received, :not_receiveed]
# end
  belongs_to :user
	has_many :package_details, :dependent => :destroy
	accepts_nested_attributes_for :package_details, :allow_destroy => true
	has_many :sending_requests,foreign_key: :laggages_id
	has_many :receiving_request, :dependent => :destroy
  has_one :payment, foreign_key: "laggage_id", class_name: "Transaction", :dependent => :destroy 
  has_many :sending_request, :dependent => :destroy
  # has_one :traveller, :dependent => :destroy
  def add_weight_to_total_weight
   	w = self.package_details.pluck(:weight).sum
    self.total_weight = w
  end

  def self.laggage_request traveller
    self.where('date >= ? and departure_state = ? and arrival_state = ?', traveller.departure_date, traveller.departure_state, traveller.arrival_state)
  end

end

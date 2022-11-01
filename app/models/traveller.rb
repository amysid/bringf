class Traveller < ApplicationRecord
  # has_many :sending_requests, dependent: :destroy
  # has_many :users, through: :sending_requests,  dependent: :destroy
  belongs_to :user
  belongs_to :laggage, optional: true
  #geocoded_by :departure_address
  #after_validation :geocode, :if => :departure_address_changed?
 

 def self.traveller_request laggage
    self.where('departure_state = ? and departure_date >= ? and arrival_state = ? and mode_of_travel = ? and weight_upto >= ? and weight_unit = ?', laggage.departure_state, laggage.date, laggage.arrival_state, laggage.mode_of_travel, laggage.total_weight, laggage.package_details.first.weight_unit)
  end

 def full_address
   "#{self.departure_meeting_address}, #{self.departure_meeting_city}, #{self.departure_meeting_state}, #{self.departure_meeting_country} - #{self.departure_meeting_zip}"
  end

end


class Commission < ApplicationRecord
  attr_accessor :check_payment_type
  belongs_to :country
  belongs_to :pricing_information
end

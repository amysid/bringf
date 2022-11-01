class ReceivingRequest < ApplicationRecord
	belongs_to :laggage
	belongs_to :receiver, class_name: 'User'
end

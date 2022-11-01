class SendingRequest < ApplicationRecord
	belongs_to :traveller
	belongs_to :laggage
	#belongs_to :receiver, class_name: 'User'
end

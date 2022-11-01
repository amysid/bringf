class State < ApplicationRecord
	belongs_to :country
	def published?
      self[:published] ? 'Yes' : 'No'
    end
end

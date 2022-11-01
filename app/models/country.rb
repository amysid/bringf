class Country < ApplicationRecord
	has_many :states, dependent: :destroy
	has_many :pricing_informations, dependent: :destroy
	has_many :commissions, dependent: :destroy
	has_many :locations, dependent: :destroy
	validates :country_name, presence: true, uniqueness: true

end

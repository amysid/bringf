class PackageDetail < ApplicationRecord
	belongs_to :laggage
	has_many :images, :dependent => :destroy
  #has_many :images, :dependent => :destroy
  accepts_nested_attributes_for :images, :allow_destroy => true

end

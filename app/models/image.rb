class Image < ApplicationRecord
  #belongs_to :imageable, :polymorphic => true
  belongs_to :package_detail
  mount_uploader :package_image, ImageUploader
end

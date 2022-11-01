class AdminUser < ApplicationRecord
   has_secure_password
   mount_uploader :image, ImageUploader

   def self.generate_password
  	seed = "--#{rand(10000000)}--#{Time.now}--#{rand(10000000)}"
    secure_password = Digest::SHA1.hexdigest(seed)[0,8]
    return secure_password
  end

end

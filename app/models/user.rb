class User < ApplicationRecord
  has_secure_password
  has_secure_token :access_token
  before_create :confirmation_token

  has_many :ratings,  foreign_key: "receiver_id", class_name: "Rating", dependent: :destroy
  has_many :laggages, dependent: :destroy
  
  has_many :travellers, dependent: :destroy  

  has_many :sending_requests, :foreign_key=>'sender_id', dependent: :destroy
  
  has_many :receiving_requests, :foreign_key => 'receiver_id', dependent: :destroy
  
  has_one :bank_detail, dependent: :destroy

  has_one :laggage_address
  #has_many :sending_requests, :foreign_key=>'sender_id', dependent: :destroy
  #has_many :travellers , through: :sending_requests, dependent: :destroy
  
  # has_many :receiving_requests
  # has_many :receive_request_user, through: :receiving_requests , source: "ReceivingRequest"
  # has_many :send_request_user, through: :receiving_requests, source: "ReceivingRequest"
  
  mount_uploader :image, ImageUploader

  validates :first_name,:last_name,:email, presence: true
  validates_uniqueness_of :email,:case_sensitive => false
    validates :email,
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i ,
            allow_blank: false,
            message: "should be valid."}    

  validates :password, presence: { message: :password_presence } , length: {
   minimum: 8,
   too_short: :password_too_short,
   maximum: 32,
   too_long: :password_too_long
  }, on: :create


  has_many :devices, dependent: :destroy

  
  def self.generate_token user
   begin
    access_token = SecureRandom.hex
  end while User.where(access_token: access_token).exists?
  end




 def password_reset(password, password_confirmation)
    self.password = password
    self.password_confirmation = password_confirmation
    self.save
 end





  def email_activate

    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end

  # private
  
  

  #p create stipe customer and save it to database
  # def create_stripe_customer(token)
  #   begin
  #     customer = Stripe::Customer.create(
  #         :description => "Customer",
  #         :source => token # "tok_1AgSL4FOTz5xielgulJcZSnt" # token generated from stripe script
  #       )
  #     self.update_attributes(stripe_customer_id: customer["id"])
  #   rescue Stripe::InvalidRequestError => e
  #     body = e.json_body
  #     err  = body[:error][:message]
  #     return false, err
  #   end
  # end

 # end
  def register_device device_type, token
    self.devices.find_or_create_by(device_type: device_type, device_token: token, user_id: self.id )
  end

  def full_address
    
    "#{self.address}, #{self.city}, #{self.state}, #{self.country} - #{self.zip}"
  end
	#has_many :laggages, dependent: :destroy
 

   def self.generate_password
    
    seed = "--#{rand(10000000)}--#{Time.now}--#{rand(10000000)}"
    secure_password = Digest::SHA1.hexdigest(seed)[0,8]
    return secure_password
  end

   private
     def confirmation_token

      if self.confirm_token.blank?
          self.confirm_token = SecureRandom.urlsafe_base64.to_s
      end
    end

end

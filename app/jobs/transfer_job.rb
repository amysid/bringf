require 'fcm'

class TransferJob < ApplicationJob
  queue_as :default

  def perform(user)
    # Do something later
    fcm = FCM.new("duJrnDVf7GE:APA91bFvzXfvgoHFAe4Zan9OPoJnNenkf800x810CT0_X6UImIluHUHHS4_pLPOQo5VH6L_B8SOwOVu89213OraL1V1jiGPNX5YSl9C8x_Hpbqjfe4zV9O8iT9_MIfHGJONKmGZBnkn4S8W-Q25ZPu1jvgySyfAVnQ")
    if user.devices.present?
      user.devices.each do |device|
        registration_ids= [device&.device_token] 
        options = { priority: 'high',data: {message: "BringItFast"},notification: {body: "#{user&.first_name} - just sent you a request",sound: 'default'}}
        response = fcm.send(registration_ids, options)
      end
    end 
  end
end

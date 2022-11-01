class Location < ApplicationRecord
  has_many :timings, dependent: :destroy

  accepts_nested_attributes_for :timings

    def full_address
    "#{self.state} #{self.city} #{self.address} #{self.zip}"
  end
    
   def update_timings(params)
    timings = params[:location][:timings_attributes]
    # loop
    timings.each do |k,v|
      time = self.timings.find_by(day: k)
      if time
        time.update_attributes(is_open: v["is_open"], open_time: v["open_time"], close_time: v["close_time"], am_or_pm_open_time: v["am_or_pm_open_time"],am_or_pm_close_time: v["am_or_pm_close_time"]  )
      end
    end
    # loop end

  end


end

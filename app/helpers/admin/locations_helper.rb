module Admin::LocationsHelper


def open_timing location,day
    timing = location.timings.find_by(day: day)
     p "-----------#{timing.inspect}----------"
    return timing.try(:open_time).strftime("%H:%M %p") rescue "" 
  end

  def close_timing location,day
     timing = location.timings.find_by(day: day)
     p "-----------#{timing.inspect}----------"
    return timing.try(:close_time).strftime("%H:%M %p") rescue ""  	
  end

  def open_close location,day 
  	open_close = location.timings.find_by(day: day).try(:is_open)
  	 p "------open_close---------#{open_close.inspect}------"
  	return open_close 
  end


end

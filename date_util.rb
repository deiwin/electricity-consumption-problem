class DateUtil

  def is_day_hour(time)
    hour_in_day_range(time) && !is_weekend(time)
  end

  private
  def hour_in_day_range(time)
    if time.dst?
      time.hour >= 8
    else
      time.hour >= 7 && time.hour < 23
    end
  end

  def is_weekend(time)
    time.sunday? || time.saturday?
  end
end

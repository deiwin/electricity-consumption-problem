class DateUtil

  class << self
    AN_HOUR_IN_SECONDS = 60 * 60

    def create_time(options)
      Time.new(options[:year], options[:month]) + (options[:hour_of_month] - 1) * AN_HOUR_IN_SECONDS
    end

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
end

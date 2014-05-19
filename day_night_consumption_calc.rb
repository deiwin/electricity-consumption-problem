require './date_util'

class DayNightConsumptionCalc < Struct.new(:year, :month)
  def initialize(h)
      super(*h.values_at(:year, :month))
  end

  def calculate(hourly_reports)
    result = {
      :night_consumption => 0,
      :day_consumption => 0
    }

    hourly_reports.each do |report|
      time = DateUtil.create_time({
        :year => year,
        :month => month,
        :hour_of_month => report[:hour_of_month]
      })
      if DateUtil.is_day_hour(time)
        result[:day_consumption] += report[:kw_consumed]
      else
        result[:night_consumption] += report[:kw_consumed]
      end
    end

    return result
  end
end

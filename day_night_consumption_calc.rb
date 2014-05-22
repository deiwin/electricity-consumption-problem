require './report_date_util'

class DayNightConsumptionCalc < Struct.new(:year, :month)
  def initialize(h)
      super(*h.values_at(:year, :month))
  end

  def calculate(hourly_reports)
    day_reports, night_reports = hourly_reports.partition(&method(:is_day_report))

    return {
      :day_consumption => sum_consumption_for_reports(day_reports),
      :night_consumption => sum_consumption_for_reports(night_reports)
    }
  end

  private
  def sum_consumption_for_reports(reports)
    reports.inject(0) {|mem, report| mem + report[:kw_consumed]}
  end

  def is_day_report(report)
    time = get_time_of_report(report)
    ReportDateUtil.is_day_hour(time)
  end

  def get_time_of_report(report)
    ReportDateUtil.create_time(report.merge({
      :year => year,
      :month => month
    }))
  end

end

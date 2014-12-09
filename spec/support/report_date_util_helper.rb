require './report_date_util'

module ReportDateUtilHelper

  def make_hour_day_hour(hour_of_month)
    time = mock_create_time_for_hour_of_month(hour_of_month)
    allow(ReportDateUtil).to receive(:is_day_hour).with(time) {true}.once
  end

  def make_hour_night_hour(hour_of_month)
    time = mock_create_time_for_hour_of_month(hour_of_month)
    allow(ReportDateUtil).to receive(:is_day_hour).with(time) {false}.once
  end

  private
  def mock_create_time_for_hour_of_month(hour_of_month)
    time = Time.new
    allow(ReportDateUtil).to receive(:create_time).with(hash_including({
      :hour_of_month => hour_of_month,
      :year => 2012,
      :month => 1
    })) {time}.once
    return time
  end
end

RSpec.configure do |c|
  c.include ReportDateUtilHelper
end

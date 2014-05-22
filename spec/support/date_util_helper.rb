require './date_util'

module DateUtilHelper

  def make_hour_day_hour(hour_of_month)
    time = mock_create_time_for_hour_of_month(hour_of_month)
    DateUtil.should_receive(:is_day_hour).with(time) {true}.once
  end

  def make_hour_night_hour(hour_of_month)
    time = mock_create_time_for_hour_of_month(hour_of_month)
    DateUtil.should_receive(:is_day_hour).with(time) {false}.once
  end

  private
  def mock_create_time_for_hour_of_month(hour_of_month)
    time = Time.new
    DateUtil.should_receive(:create_time).with(hash_including({
      :hour_of_month => hour_of_month,
      :year => 2012,
      :month => 1
    })) {time}.once
    return time
  end
end

RSpec.configure do |c|
  c.include DateUtilHelper
end

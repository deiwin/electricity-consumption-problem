require './date_util'
require 'date'

describe DateUtil do
  describe '#create_time' do
    it 'should create a time from year, month and hour of month' do
      DateUtil.create_time({
        :year => 2012,
        :month => 1,
        :hour_of_month => 744
        }).should eql(Time.new(2012, 1, 31, 23))

      DateUtil.create_time({
        :year => 2012,
        :month => 1,
        :hour_of_month => 1
        }).should eql(Time.new(2012, 1, 1, 0))
    end
  end

  describe '#is_day_hour' do
    it 'should return false for night hours' do
      (0..6).each do |hour|
        DateUtil.is_day_hour(Time.new(2012, 1, 2, hour)).should be_false
      end
      DateUtil.is_day_hour(Time.new(2012, 1, 2, 23)).should be_false
    end

    it 'should return true for day hours' do
      (7..22).each do |hour|
        DateUtil.is_day_hour(Time.new(2012, 1, 2, hour)).should be_true
      end
    end

    it 'should return false for night hours during daylight saving' do
      (0..7).each do |hour|
        DateUtil.is_day_hour(Time.new(2012, 6, 4, hour)).should be_false
      end
    end

    it 'should return true for day hours during daylight saving' do
      (8..23).each do |hour|
        DateUtil.is_day_hour(Time.new(2012, 6, 4, hour)).should be_true
      end
    end

    it 'should return false for all hours during sundays' do
      (0..23).each do |hour|
        DateUtil.is_day_hour(Time.new(2012, 1, 1, hour)).should be_false
      end
    end

    it 'should return false for all hours during saturdays' do
      (0..23).each do |hour|
        DateUtil.is_day_hour(Time.new(2012, 1, 7, hour)).should be_false
      end
    end
  end
end

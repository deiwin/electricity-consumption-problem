require './report_date_util'
require 'date'

describe ReportDateUtil do
  describe '#create_time' do
    it 'should create a time from year, month and hour of month' do
      expect(described_class.create_time({
        :year => 2012,
        :month => 1,
        :hour_of_month => 744
        })).to eq(Time.new(2012, 1, 31, 23))

      expect(described_class.create_time({
        :year => 2012,
        :month => 1,
        :hour_of_month => 1
        })).to eq(Time.new(2012, 1, 1, 0))
    end
  end

  describe '#is_day_hour' do
    it 'should return false for night hours' do
      (0..6).each do |hour|
        expect_to_be_night(Time.new(2012, 1, 2, hour))
      end
      expect_to_be_night(Time.new(2012, 1, 2, 23))
    end

    it 'should return true for day hours' do
      (7..22).each do |hour|
        expect_to_be_day(Time.new(2012, 1, 2, hour))
      end
    end

    it 'should return false for night hours during daylight saving' do
      (0..7).each do |hour|
        expect_to_be_night(Time.new(2012, 6, 4, hour))
      end
    end

    it 'should return true for day hours during daylight saving' do
      (8..23).each do |hour|
        expect_to_be_day(Time.new(2012, 6, 4, hour))
      end
    end

    it 'should return false for all hours during sundays' do
      (0..23).each do |hour|
        expect_to_be_night(Time.new(2012, 1, 1, hour))
      end
    end

    it 'should return false for all hours during saturdays' do
      (0..23).each do |hour|
        expect_to_be_night(Time.new(2012, 1, 7, hour))
      end
    end

    def expect_to_be_day(time)
      expect(described_class.is_day_hour(time)).to be true
    end

    def expect_to_be_night(time)
      expect(described_class.is_day_hour(time)).to be false
    end
  end
end

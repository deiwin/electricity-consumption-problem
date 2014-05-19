require './day_night_consumption_calc'
require './date_util'

describe DayNightConsumptionCalc do

  it 'should have constructor for year, month' do
    calc = DayNightConsumptionCalc.new({
      :year => 2013,
      :month => 5
    })

    calc.year.should eq(2013)
    calc.month.should eq(5)
  end

  context 'with calculator for Jan 2012' do
    let(:calc) {
      DayNightConsumptionCalc.new({
        :year => 2012,
        :month => 1
      })
    }

    describe '#calculate' do
      it 'should sum night hours' do
        DateUtil.should_receive(:is_day_hour) {false}.twice

        result = calc.calculate([
          {
            :kw_consumed => 2,
            :hour_of_month => 1
          }, {
            :kw_consumed => 4,
            :hour_of_month => 2
          }
        ])

        result.should include(:night_consumption => 6)
      end

      it 'should sum day hours' do
        DateUtil.should_receive(:is_day_hour) {true}.twice

        result = calc.calculate([
          {
            :kw_consumed => 2,
            :hour_of_month => 1
          }, {
            :kw_consumed => 4,
            :hour_of_month => 2
          }
        ])

        result.should include(:day_consumption => 6)
      end

      it 'should check if is day with proper time' do
        time1 = Time.new
        time2 = Time.new

        DateUtil.should_receive(:create_time).with(hash_including({
          :hour_of_month => 1,
          :year => 2012,
          :month => 1
        })) {time1}.once
        DateUtil.should_receive(:create_time).with(hash_including({
          :hour_of_month => 2,
          :year => 2012,
          :month => 1
        })) {time2}.once
        DateUtil.should_receive(:is_day_hour).with(time1) {true}.once
        DateUtil.should_receive(:is_day_hour).with(time2) {false}.once

        result = calc.calculate([
          {
            :kw_consumed => 2,
            :hour_of_month => 1
          }, {
            :kw_consumed => 4,
            :hour_of_month => 2
          }
        ])

        result.should include(:day_consumption => 2)
        result.should include(:night_consumption => 4)
      end
    end
  end
end

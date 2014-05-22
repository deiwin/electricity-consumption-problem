require './day_night_consumption_calc'
require './date_util'
require_relative 'support/date_util_helper'

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

      context 'with mocked night and day reports' do
        before(:each) do
          make_hour_day_hour(1)
          make_hour_night_hour(2)
        end

        it 'should calculate consumption for both night and day' do
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
end

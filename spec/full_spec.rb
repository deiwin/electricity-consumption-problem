require './consumption_parser'
require './day_night_consumption_calc'

describe 'Example data' do
  let(:parser) {ConsumptionParser.new}
  let(:calc) {
    DayNightConsumptionCalc.new({
      :year => 2012,
      :month => 1
    })
  }

  it 'should get the same results as given on the problem\'s web page' do
    report_lines = [
      '1 - 2kW (hour #1 is January 1, Sunday, 00:00 - 01:00 - NIGHT)',
      '2 - 3kW (hour #2 is January 1, Sunday, 01:00 - 02:00 - NIGHT)',
      '26 - 3kW (hour #26 is January 2, Monday, 01:00 - 02:00 - NIGHT)',
      '32 - 6kW (hour #32 is January 2, Monday, 07:00 - 08:00 - DAY)',
      '744 - 0kW (hour #744 is January 31, 23:00 - 24:00)'
    ]
    reports = report_lines.map { |report_line| parser.parse_line(report_line)}

    result = calc.calculate(reports)

    result.should include(:day_consumption => 6)
    result.should include(:night_consumption => 8)
  end

  it 'should also solve a bit more complex example' do
    report_lines = [
      '1 - 2kW (hour #1 is January 1, Sunday, 00:00 - 01:00 - NIGHT)',
      '9 - 3kW (hour #9 is January 1, Sunday, 08:00 - 09:00 - NIGHT)',
      '26 - 3kW (hour #26 is January 2, Monday, 01:00 - 02:00 - NIGHT)',
      '32 - 6kW (hour #32 is January 2, Monday, 07:00 - 08:00 - DAY)',
      '744 - 7kW (hour #744 is January 31, Tuesday, 23:00 - 24:00 - NIGHT)'
    ]
    reports = report_lines.map { |report_line| parser.parse_line(report_line)}

    result = calc.calculate(reports)

    result.should include(:day_consumption => 6)
    result.should include(:night_consumption => 15)
  end
end

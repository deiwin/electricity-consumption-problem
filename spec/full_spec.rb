require './report_parser'
require './day_night_consumption_calc'

describe 'Example data' do
  let(:parser) {ReportParser.new}
  let(:calc) {
    DayNightConsumptionCalc.new({
      :year => 2012,
      :month => 1
    })
  }

  context 'with sample data from the problem\'s web page' do
    let(:report_lines) {[
      '1 - 2kW (hour #1 is January 1, Sunday, 00:00 - 01:00 - NIGHT)',
      '2 - 3kW (hour #2 is January 1, Sunday, 01:00 - 02:00 - NIGHT)',
      '26 - 3kW (hour #26 is January 2, Monday, 01:00 - 02:00 - NIGHT)',
      '32 - 6kW (hour #32 is January 2, Monday, 07:00 - 08:00 - DAY)',
      '744 - 0kW (hour #744 is January 31, 23:00 - 24:00)'
    ]}

    it 'should get the same results as given on the problem\'s web page' do
      reports = report_lines.map { |report_line| parser.parse_line(report_line)}

      result = calc.calculate(reports)

      expect(result).to include(:day_consumption => 6)
      expect(result).to include(:night_consumption => 8)
    end
  end

  context 'with a bit more complex example' do
    let(:report_lines) {[
      '1 - 2kW (hour #1 is January 1, Sunday, 00:00 - 01:00 - NIGHT)',
      '9 - 3kW (hour #9 is January 1, Sunday, 08:00 - 09:00 - NIGHT)',
      '26 - 3kW (hour #26 is January 2, Monday, 01:00 - 02:00 - NIGHT)',
      '32 - 6kW (hour #32 is January 2, Monday, 07:00 - 08:00 - DAY)',
      '744 - 7kW (hour #744 is January 31, Tuesday, 23:00 - 24:00 - NIGHT)'
    ]}

    it 'should still calculate correct consumption totals' do
      reports = report_lines.map { |report_line| parser.parse_line(report_line)}

      result = calc.calculate(reports)

      expect(result).to include(:day_consumption => 6)
      expect(result).to include(:night_consumption => 15)
    end
  end
end

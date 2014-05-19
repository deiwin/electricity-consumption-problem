require './report_parser'

describe ReportParser do
  let(:parser) {ReportParser.new}

  describe '#parse_line' do
    context 'with parsed sample' do
      let(:parsed) {parser.parse_line('32 - 6kW (hour #32 is January 2, Monday, 07:00 - 08:00 - DAY)')}

      it 'should parse kW consumed' do
        parsed[:kw_consumed].should eq(6);
      end

      it 'should parse the hour of month' do
        parsed[:hour_of_month].should eq(32);
      end
    end
  end
end

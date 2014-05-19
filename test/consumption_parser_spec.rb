require './consumption_parser'

describe ConsumptionParser do
  let(:parser) {ConsumptionParser.new}

  describe '#parse_line' do
    it 'should parse kW consumed' do
      parsed = parser.parse_line('32 - 6kW (hour #32 is January 2, Monday, 07:00 - 08:00 - DAY)')

      parsed[:kw_consumed].should eq(6);
    end

    it 'should parse the hour of month' do
      parsed = parser.parse_line('32 - 6kW (hour #32 is January 2, Monday, 07:00 - 08:00 - DAY)')

      parsed[:hour_of_month].should eq(32);
    end
  end
end

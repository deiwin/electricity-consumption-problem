class ReportParser

  def parse_line(line)
    line_splits = line.split(' ')

    result = {
      :kw_consumed => line_splits[2][0..-3].to_i,
      :hour_of_month => line_splits[0].to_i
    }
  end
end

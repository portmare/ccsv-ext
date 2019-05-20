require "test_helper"

class CcsvExtTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::CcsvExt::VERSION
  end

  def parse_normal_line
    assert_equal CcsvExt.parse_line('a;bbbb;parse normal line;;;instance', ';'), ['a', 'bbbb', 'parse normal line', '', '', 'instance']
  end

  def parse_line_with_quotes
    assert_equal CcsvExt.parse_line('"a";bb;"c";;d', ';'), ['a', 'bb', 'c', '', 'd']
  end

  def parse_line_with_multibytes
    assert_equal CcsvExt.parse_line('"a";bb;"текст";;d', ';'), ['a', 'bb', 'текст', '', 'd']
  end

  def parse_line_with_quotes_and_empties
    assert_equal CcsvExt.parse_line('"a";"";b;"c";d', ';'), ['a', '', 'b', 'c', 'd']
  end

  def parse_line_with_many_quotes_and_ended_with_delimeter
    assert_equal CcsvExt.parse_line('"a";b;"c";"""d""";', ';'), ['a', 'b', 'c', '"d"', ""]
  end

  def parse_with_EOL_symbol
    assert_equal CcsvExt.parse_line("false;3;;;instance1\n", ';'), ["false", "3", "", "", "instance1"]
  end
end

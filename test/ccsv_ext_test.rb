require "test_helper"

class CcsvExtTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::CcsvExt::VERSION
  end

  def test_parse_normal_line
    assert_equal CcsvExt.parse_line('a;bbbb;parse normal line;;;instance', ';'), ['a', 'bbbb', 'parse normal line', '', '', 'instance']
  end

  def test_parse_line_with_quotes
    assert_equal CcsvExt.parse_line('"a";bb;"c";;d', ';'), ['a', 'bb', 'c', '', 'd']
  end

  def test_parse_line_with_multibytes
    assert_equal CcsvExt.parse_line('"a";bb;"текст";;d', ';'), ['a', 'bb', 'текст', '', 'd']
  end

  def test_parse_line_with_quotes_and_empties
    assert_equal CcsvExt.parse_line('"a";"";b;"c";d', ';'), ['a', '', 'b', 'c', 'd']
  end

  def test_parse_line_with_many_quotes_and_ended_with_delimeter
    assert_equal CcsvExt.parse_line('"a";b;"c";"""d""";', ';'), ['a', 'b', 'c', '"d"', ""]
  end

  def test_parse_with_EOL_symbol
    assert_equal CcsvExt.parse_line("false;3;;;instance1\n", ';'), ["false", "3", "", "", "instance1"]
  end

  def test_parse_line_with_long_string
    assert_equal CcsvExt.parse_line("1;o1+P54QsfqwuRnc/qC7z3v1YHP6QY4Qv/l0icPnq0NAG+63sYalk7BG/btoatokpke/uAtoIBR7izQqLt6n4J3DAhFsxlekwZ0cDoeLUMoxjgDSZn+pIDhtB0RDvV2tjVVo0XPBXQg90euIt9P+iE7FRK53JjXytjIRkr9uY9Ewi7uNyQTZBorBMhrkQsDzRJsFrf+9D94raED8N3UC9g/u0YRpxYkitWToOBUfglfvGf/Lo/Dd31v/g9dyZOrcDA56E+ZHBo8Hn8WKm4FiLLZc1HTQTr7uxothLzEwii7bMOk2SP3o2t8AxYBp9OzbKuqroGrlDVkDgS2M5wHM0BDr3YDr3a9RU49yvnN6gRXdHaxf30c3w9ujl+sMjD9F+s5fDVwud0OuM7r6ZeMFoVASacCdwuvNfsBlNOYnGtRK3WRv6hXntkOC8EQYjbKWuwD3rSzbcVDrqeZG4r6MqxrLY46J1D0Gci7tMJ/V709/Qs57V/A4nLv+RVM8ZKiGrGjKBTYUMHMLN79wEnTRWSTNDoTsplpqRBCuMJYC7OX1DNvjGcpK7DKhuLFbQ19J0dglq3FyvpnUz36lVl/I/ikyOVO1QmyrwuuDvPhUbqfNUAQAO4ghvfqweCGRxXzOsSlsZxpbStjVhD85BFgdPOUy4bRCOKddZXQ=;3;last_element", ';'),
                   ["1", "o1+P54QsfqwuRnc/qC7z3v1YHP6QY4Qv/l0icPnq0NAG+63sYalk7BG/btoatokpke/uAtoIBR7izQqLt6n4J3DAhFsxlekwZ0cDoeLUMoxjgDSZn+pIDhtB0RDvV2tjVVo0XPBXQg90euIt9P+iE7FRK53JjXytjIRkr9uY9Ewi7uNyQTZBorBMhrkQsDzRJsFrf+9D94raED8N3UC9g/u0YRpxYkitWToOBUfglfvGf/Lo/Dd31v/g9dyZOrcDA56E+ZHBo8Hn8WKm4FiLLZc1HTQTr7uxothLzEwii7bMOk2SP3o2t8AxYBp9OzbKuqroGrlDVkDgS2M5wHM0BDr3YDr3a9RU49yvnN6gRXdHaxf30c3w9ujl+sMjD9F+s5fDVwud0OuM7r6ZeMFoVASacCdwuvNfsBlNOYnGtRK3WRv6hXntkOC8EQYjbKWuwD3rSzbcVDrqeZG4r6MqxrLY46J1D0Gci7tMJ/V709/Qs57V/A4nLv+RVM8ZKiGrGjKBTYUMHMLN79wEnTRWSTNDoTsplpqRBCuMJYC7OX1DNvjGcpK7DKhuLFbQ19J0dglq3FyvpnUz36lVl/I/ikyOVO1QmyrwuuDvPhUbqfNUAQAO4ghvfqweCGRxXzOsSlsZxpbStjVhD85BFgdPOUy4bRCOKddZXQ=", "3", "last_element"]
  end
end

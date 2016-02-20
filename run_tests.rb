require 'test/unit'

require_relative 'test/test_rational'


def run_tests
  Test::Unit::AutoRunner.run(TestRational)
end


if __FILE__ == $0
  run_tests
end

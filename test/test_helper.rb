require 'simplecov'
SimpleCov.start

if 'true' == ENV['CI']
  require 'codecov'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end

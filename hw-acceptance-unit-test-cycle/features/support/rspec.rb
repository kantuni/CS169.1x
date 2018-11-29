# frozen_string_literal: true

require 'rspec/core'

RSpec.configure do |config|
  config.mock_with :rspec do |c|
    c.syntax = %i[should expect]
  end
  config.expect_with :rspec do |c|
    c.syntax = %i[should expect]
  end
end

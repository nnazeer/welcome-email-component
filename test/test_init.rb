ENV['CONSOLE_DEVICE'] ||= 'stdout'
ENV['LOG_LEVEL'] ||= '_min'

puts RUBY_DESCRIPTION

require_relative '../init.rb'

require 'test_bench'; TestBench.activate

require 'pp'

require 'welcome_email_component/controls'
require 'registration/client/controls'

module WelcomeEmailComponent; end
include WelcomeEmailComponent

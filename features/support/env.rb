# Generated by cucumber-sinatra. (2014-01-05 15:11:33 +0000)

ENV['RACK_ENV'] = 'test'

require File.join(File.dirname(__FILE__), '..', '..', 'lib/quiz_app.rb')

require 'capybara'
require 'capybara/cucumber'
require 'rspec'

Capybara.app = QuizApp

class QuizAppWorld
  include Capybara::DSL
  include RSpec::Expectations
  include RSpec::Matchers
end

World do
  QuizAppWorld.new
end

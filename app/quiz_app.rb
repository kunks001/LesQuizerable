require 'sinatra/base'
require 'haml'
require 'data_mapper'
require 'dm-postgres-adapter'
require 'rack-flash'
require 'aws/s3'
require "sinatra/base"
require "sinatra/config_file"
require "sinatra/namespace"
require 'active_support/core_ext/hash'
require 'sinatra/partial'
require "sinatra/jsonp"
require 'json'

class QuizApp < Sinatra::Base
  env = ENV["RACK_ENV"] || "development"

  DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/lesquizerables_#{env}")
  Dir["./app/models/*.rb"].each {|file| require file }
  DataMapper.finalize
  DataMapper.auto_upgrade!

  enable :sessions
  set :session_secret, 'super secret'
  set :views, Proc.new { File.join("./app/views") }
  set :public_folder, Proc.new { File.join(root, 'public') }
  set :static, true
  set :partial_template_engine, :haml

  register Sinatra::Partial

  use Rack::Flash
  use Rack::MethodOverride

  register Sinatra::ConfigFile
  config_file '../config/config.yml'
  register Sinatra::Namespace

  Dir["./app/controllers/*.rb"].each {|file| require file }
  Dir["./app/helpers/*.rb"].each {|file| require file }
  require_relative 'helpers/application'
  helpers ImageUploadHelper
  helpers ApplicationHelper
  helpers Sinatra::Jsonp

  # start the server if ruby file executed directly
  run! if app_file == $0
end

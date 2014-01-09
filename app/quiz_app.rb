require 'sinatra/base'
require 'haml'
require 'sinatra/twitter-bootstrap'
require 'data_mapper'
require 'dm-postgres-adapter'
require 'rack-flash'
require 'aws/s3'
require "sinatra/base"
require "sinatra/config_file"

class QuizApp < Sinatra::Base
  env = ENV["RACK_ENV"] || "development"

  DataMapper.setup(:default, "postgres://localhost/lesquizerables_#{env}")
  Dir["./app/models/*.rb"].each {|file| require file }
  DataMapper.finalize
  DataMapper.auto_upgrade!

  enable :sessions
  set :session_secret, 'super secret'
  set :views, Proc.new { File.join("./app/views") }
  set :public_folder, Proc.new { File.join(root, 'public') }
  set :static, true

  use Rack::Flash
  use Rack::MethodOverride

  register Sinatra::ConfigFile
  config_file '../config/config.yml'

  register Sinatra::Twitter::Bootstrap::Assets

  Dir["./app/controllers/*.rb"].each {|file| require file }
  require_relative 'helpers/application'
  helpers ApplicationHelper

  get '/' do
    haml :index
  end
  
  # start the server if ruby file executed directly
  run! if app_file == $0
end

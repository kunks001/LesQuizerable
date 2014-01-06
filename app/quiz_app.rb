require 'sinatra/base'
require 'haml'
require 'sinatra/twitter-bootstrap'
require 'data_mapper'
require 'dm-postgres-adapter'
require 'rack-flash'

class QuizApp < Sinatra::Base
  env = ENV["RACK_ENV"] || "development"

  DataMapper.setup(:default, "postgres://localhost/lesquizerables_#{env}")
  require './app/models/admin'
  DataMapper.finalize
  DataMapper.auto_upgrade!

  enable :sessions

  set :session_secret, 'super secret'
  set :views, Proc.new { File.join("./app/views") }
  set :public_folder, 'public'

  register Sinatra::Twitter::Bootstrap::Assets

  require './app/controllers/admins'
  require './app/controllers/sessions'

  require_relative 'helpers/application'
  helpers ApplicationHelper


  use Rack::Flash
  use Rack::MethodOverride

  get '/' do
    haml :index
  end
  
  # start the server if ruby file executed directly
  run! if app_file == $0
end

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
  set :views, Proc.new { File.join("views") }

  register Sinatra::Twitter::Bootstrap::Assets

  require './app/controllers/admins'
  require './app/controllers/sessions'


  use Rack::Flash
  use Rack::MethodOverride

  get '/' do
    haml :index
  end

  helpers do

    def current_admin    
      @current_admin ||= Admin.get(session[:admin_id]) if session[:admin_id]
    end

  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end

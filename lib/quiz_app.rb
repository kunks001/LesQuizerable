require 'sinatra/base'
require 'haml'
require 'sinatra/twitter-bootstrap'
require 'data_mapper'
require 'dm-postgres-adapter'

class QuizApp < Sinatra::Base
  env = ENV["RACK_ENV"] || "development"

  DataMapper.setup(:default, "postgres://localhost/lesquizerables_#{env}")
  require './lib/admin'
  DataMapper.finalize
  DataMapper.auto_upgrade!

  enable :sessions

  set :session_secret, 'super secret'
  set :views, Proc.new { File.join("views") }

  register Sinatra::Twitter::Bootstrap::Assets

  get '/' do
    haml :index
  end

  get '/admin/create-admin' do
    haml :"admin/create-admin"
  end

  post '/admin/create-admin' do
    admin = Admin.create(:email => params[:email], 
              :password => params[:password])
    session[:admin_id] = admin.id
    redirect to('/')
  end

  helpers do

    def current_admin    
      @current_admin ||= Admin.get(session[:admin_id]) if session[:admin_id]
    end

  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end

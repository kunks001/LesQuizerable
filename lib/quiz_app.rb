require 'sinatra/base'
require 'haml'
require 'sinatra/twitter-bootstrap'
require 'data_mapper'
require 'dm-postgres-adapter'
require 'rack-flash'

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

  use Rack::Flash

  get '/' do
    haml :index
  end

  get '/admin/create-admin' do
    @admin = Admin.new
    haml :"admin/create-admin"
  end

  post '/admin/create-admin' do
    @admin = Admin.new(:email => params[:email], 
              :password => params[:password],
              :password_confirmation => params[:password_confirmation]
              )
    if @admin.save
      session[:admin_id] = admin.id
      redirect to('/')
    else
      flash.now[:errors] = @user.errors.full_messages
      # flash[:notice] = "Sorry, your passwords don't match"
      erb :"admin/create-admin"
    end
  end

  get '/sessions/new' do
    haml :"sessions/new"
  end

  post '/sessions' do
    email, password = params[:email], params[:password]
    admin = Admin.authenticate(email, password)
    if admin
      session[:admin_id] = admin.id
      redirect to('/')
    else
      flash[:errors] = ["The email or password are incorrect"]
      haml :"sessions/new"
    end
  end

  helpers do

    def current_admin    
      @current_admin ||= Admin.get(session[:admin_id]) if session[:admin_id]
    end

  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end

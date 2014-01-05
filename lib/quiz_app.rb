require 'sinatra/base'
require 'haml'
require 'sinatra/twitter-bootstrap'
require 'data-mapper'

class QuizApp < Sinatra::Base
  env = ENV["RACK_ENV"] || "development"

  DataMapper.setup(:default, "postgres://localhost/lesquizerables_#{env}")
  require './lib/admin'
  DataMapper.finalize
  DataMapper.auto_upgrade!

  set :views, Proc.new { File.join("views") }

  register Sinatra::Twitter::Bootstrap::Assets

  get '/' do
    haml :index
  end

  get '/admin/create-admin' do
    haml :"admin/create-admin"
  end

  post '/admin/create-admin' do
    Admin.create(:email => params[:email], 
              :password => params[:password])
    redirect to('/')
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end

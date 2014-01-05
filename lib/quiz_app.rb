require 'sinatra/base'
require 'haml'
require 'sinatra/twitter-bootstrap'

class QuizApp < Sinatra::Base
  set :views, Proc.new { File.join("views") }

  register Sinatra::Twitter::Bootstrap::Assets

  get '/' do
    haml :index
  end

  get '/admins/sign_up' do
    haml :"admins/sign_up"
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end

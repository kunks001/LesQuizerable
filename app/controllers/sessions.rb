class QuizApp < Sinatra::Base

  get '/sessions/new' do
    haml :"sessions/new"
  end

  post '/sessions' do
    email, password = params[:email], params[:password]
    admin = Admin.authenticate(email, password)
    if admin
      session[:admin_id] = admin.id
      redirect to('/quizzes')
    else
      flash[:errors] = ["The email or password are incorrect"]
      haml :"sessions/new"
    end
  end

  delete '/sessions' do
    session[:admin_id] = nil
    redirect to '/quizzes'
  end
  
end
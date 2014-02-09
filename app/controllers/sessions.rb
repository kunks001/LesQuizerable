class QuizApp < Sinatra::Base
  
  get '/sessions/new' do
    haml :"sessions/new"
  end

  post '/sessions' do
    email, password = params[:email], params[:password]
    admin = Admin.authenticate(email, password)
    if admin
      session[:admin_id] = admin.id
      flash[:notice] = "Signed in successfully."
      redirect to('/quizzes')
    else
      flash[:error] = "The email or password are incorrect"
      redirect to('/sessions/new')
    end
  end

  delete '/sessions' do
    session[:admin_id] = nil
    flash[:notice] = "Signed out successfully."
    redirect to('/sessions/new')
  end
  
end
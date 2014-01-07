class QuizApp < Sinatra::Base

	get '/quizzes/new' do
		if session[:admin_id]
			@quiz = Quiz.new
			haml :"quizzes/new"
		else
			redirect to '/sessions/new'
		end
	end
		
end
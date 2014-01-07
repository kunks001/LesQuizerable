class QuizApp < Sinatra::Base

	get '/quizzes' do
		if session[:admin_id]
			@quizzes = Quiz.all
			haml :"quizzes/index"
		else
			redirect to '/sessions/new'
		end
	end

	get '/quizzes/new' do
		if session[:admin_id]
			@quiz = Quiz.new
			haml :"quizzes/new"
		else
			redirect to '/sessions/new'
		end
	end
		
end
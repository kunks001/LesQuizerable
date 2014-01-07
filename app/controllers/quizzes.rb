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

	post '/quizzes/new' do
		@quiz = Quiz.new(:title => params[:title])
		@quiz.questions = params[:question]
		@quiz.questions.each do |q|
			q.answers = params[:answer].map {|a| Answer.new(response: a["response"]) }
		end
		# @quiz = params[:quiz]
		# raise "#{@quiz.questions}"
		if @quiz.save
			redirect to '/quizzes'
		else
			flash.now[:errors] = ["Sorry, your Quiz was unable to save. Please try again"]
			haml :"quizzes/new"
		end
	end
		
end
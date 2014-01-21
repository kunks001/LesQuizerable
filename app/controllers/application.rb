class QuizApp < Sinatra::Base

  get '/' do
    @homepage = true
    @quiz = Quiz.first(:displayed => true)
    if @quiz
      haml :"attempts/new"
    else
      haml :"quizzes/no_quiz"
    end
  end
end
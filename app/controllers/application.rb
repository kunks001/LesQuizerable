class QuizApp < Sinatra::Base

  get '/' do
    @homepage = true
    @quiz = Quiz.first(:displayed => true)
    # if @quiz
      haml :"attempts/new"
    # else
    #   haml :"quizzes/holding-page"
    # end
  end
end
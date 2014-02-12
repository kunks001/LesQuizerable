class QuizApp < Sinatra::Base

  get '/' do
    @homepage = true
    @quiz = Quiz.first(:displayed => true)
    haml :"attempts/new"
  end
end
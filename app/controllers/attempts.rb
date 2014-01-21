class QuizApp < Sinatra::Base
 
  get '/attempts/:id/new' do
    @quiz = Quiz.get(params[:id])
    # @questions = @quiz.questions
    haml :"attempts/new"
  end
 
  post '/attempts/:id' do
    @quiz = Quiz.get(params[:id])
    scorer = Scorer.new(@quiz)
    haml :index
    flash[:notice] = "#{scorer.total(params[:answer_ids].values)}%"
    # redirect to '/'
  end
 
end
class QuizApp < Sinatra::Base
 
  get '/attempts/:id/new' do
    @quiz = Quiz.get(params[:id])
    # @questions = @quiz.questions
    haml :"attempts/new"
  end
 
  # post '/attempts/:id' do
  #   @quiz = Quiz.get(params[:id])
  #   scorer = Scorer.new(@quiz)
  #   haml :index
  #   flash[:notice] = "#{scorer.total(params[:answer_ids].values)}%"
  #   # redirect to '/'
  # end
  post '/attempts/:id' do
    content_type 'application/json'
    @quiz = Quiz.get(params[:id])
    scorer = Scorer.new(@quiz)
    score = ["#{scorer.total(params[:answer_ids].values)}%"]
    score.to_json
  end
 
end
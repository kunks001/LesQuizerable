class QuizApp < Sinatra::Base

  get '/attempts/:id/new' do
    @quiz = Quiz.get(params[:id])
    # @questions = @quiz.questions
    haml :"attempts/new"
  end

  post '/attempts/:id' do
    # raise params.inspect
    params[:contact] == "yes" ? c = true : c = false
    
    visitor = Visitor.new(:email => params[:email],
                          :name => params[:name],
                          :description => params[:description],
                          :contact => c
                          )

    @quiz = Quiz.get(params[:id])
    scorer = Scorer.new(@quiz)

    if visitor.save
      score = ["#{scorer.total(params[:answer_ids].values)}%"]
      score.to_json
    else
      score = 'sorry, something went wrong.'
      score.to_json
    end
  end

  post '/attempts/' do
    params[:contact] == "yes" ? c = true : c = false

    visitor = Visitor.new(:email => params[:email],
                          :name => params[:name],
                          :description => params[:description],
                          :contact => c,
                          :created_at => Time.now
                          )
    if visitor.save
      score = "Thanks!"
      score.to_json
    else
      score = 'sorry, something went wrong.'
      score.to_json
    end
  end
 
end
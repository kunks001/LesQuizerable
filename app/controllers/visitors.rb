class QuizApp < Sinatra::Base

  get '/visitors' do
    @visitors = Visitor.all(:order => [:created_at.desc])
    haml :"visitors/index"
  end
end
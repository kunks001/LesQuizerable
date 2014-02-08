class QuizApp < Sinatra::Base

  namespace '/quizzes' do

    before { redirect to 'sessions/new' if current_admin == nil }

    get '' do
        @quizzes = Quiz.all
        haml :"quizzes/index"
    end

    get '/new' do
        @quiz = Quiz.new
        haml :"quizzes/new"
    end

    post '/new' do
      quiz = Quiz.new(:title => params[:title])
      # quiz.save_questions_and_answers(params[:question],quiz)
      quiz.add_questions(params[:question],quiz)
      if quiz.save
        quiz.show_on_homepage(Quiz.all) if params[:displayed] == "on"
        redirect to '/quizzes'
      else
        flash.now[:errors] = ["Sorry, your Quiz was unable to save. Please try again"]
        haml :"quizzes/new"
      end
    end

    get '/:id/edit' do
      @quiz = Quiz.get(params[:id])
      questions = @quiz.questions
      @questions = questions.map {|q| {q => q.answers} }
      haml :"quizzes/edit"
    end

    post '/:id/edit' do
      quiz = Quiz.get(params[:id])
      quiz.update(:title => params[:title])
      quiz.edit_questions(params[:question],quiz)
      quiz.show_on_homepage(Quiz.all) if params[:displayed] == "on"
      quiz.take_off_homepage if params[:displayed] == nil
      if quiz.save
        redirect to '/quizzes'
      else
        flash.now[:errors] = ["Sorry,your Quiz was unable to save. Please try again"]
        haml :"quizzes/edit"
      end
    end

    delete '' do
      quiz = Quiz.get(params[:quiz_id])
      quiz.destroy
      redirect to '/quizzes'
    end

    get '/:id' do
      @quiz = Quiz.get(params[:id])
      haml :"quizzes/show"
    end
  end
end
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
      params[:displayed] == "on" ? c = true : c = false

      if c == true
        q = Quiz.first(:displayed => true)
        if q
          q.update(:displayed => false)
          q.save
        end
      end

      quiz = Quiz.new(:title => params[:title], 
                      :displayed => c)
      hash = params[:question]
      quiz.save_questions_and_answers(hash,quiz)
      if quiz.save
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
      params[:displayed] == "on" ? c = true : c = false

      if c == true
        q = Quiz.first(:displayed => true)
        if q
          q.update(:displayed => false)
          q.save
        end
      end

      quiz = Quiz.get(params[:id])
      quiz.update(:title => params[:title],
                  :displayed => true)
      hash = params[:question]
      quiz.edit_questions_and_answers(hash,quiz)
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
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

    hash = params[:question]
    hash.each do |key, value|
      text = value["question_text"]
      @q = Question.new(question_text: text)
      if value["file"]
        file  = value["file"][:tempfile]
        filename = value["file"][:filename]
        upload(file, filename)
      end

      @q.image = Image.create(:filename => filename)
      answers = value["answer"]
      answers.each do |key, value|
        r = value["response"]
        value["correctness"] == "on" ? c = true : c = false
        @q.answers << Answer.new(:response => r, :correctness => c)
      end
      @quiz.questions << @q
    end
    if @quiz.save
      redirect to '/quizzes'
    else
      flash.now[:errors] = ["Sorry, your Quiz was unable to save. Please try again"]
      haml :"quizzes/new"
    end
  end

  def upload(file,filename)
    awskey     = settings.access_key_id
    awssecret  = settings.secret_access_key
    bucket     = 'MakersQuizApp'

    AWS::S3::Base.establish_connection!(
      :access_key_id     => awskey,
      :secret_access_key => awssecret
    )
    
    ok_response = AWS::S3::S3Object.store(
      filename,
      open(file.path),
      bucket,
      :access => :public_read
    ).response

    ok_response
  end

  get '/quizzes/:id/edit' do
    if session[:admin_id]
      @quiz = Quiz.get(params[:id])
      questions = @quiz.questions
      @questions = questions.map {|q| {q => q.answers} }
      haml :"quizzes/edit"
    else
      redirect to '/sessions/new'
    end
  end

  post '/quizzes/:id/edit' do
    @quiz = Quiz.get(params[:id])
    @quiz.update(:title => params[:title])
    hash = params[:question]
    hash.each do |key, value|
      text = value["question_text"]
      @question = Question.get(key.to_i)
      @question.update(:question_text => text)
      answers = value["answer"]
      answers.each do |key, value|
        @answer = Answer.get(key.to_i)
        r = value["response"]
        @answer.update(:response => r)
      end
    end
    if @quiz.save
      redirect to '/quizzes'
    else
      flash.now[:errors] = ["Sorry,your Quiz was unable to save. Please try again"]
      haml :"quizzes/edit"
    end
  end

  delete '/quizzes' do
    quiz = Quiz.get(params[:quiz_id])
    quiz.destroy
    redirect to '/quizzes'
  end
end
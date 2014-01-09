module ApplicationHelper

  def current_admin    
    @current_admin ||= Admin.get(session[:admin_id]) if session[:admin_id]
  end

  def editable_by_admin_with(id)
    (current_admin.super_admin? || (current_admin.id == id.to_i))
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

  def save_questions_and_answers(hash,quiz)
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
        if value["file"]
          file  = value["file"][:tempfile]
          filename = value["file"][:filename]
          upload(file, filename)
        end
        r = value["response"]
        value["correctness"] == "on" ? c = true : c = false
        @a = Answer.new(:response => r, :correctness => c)
        @a.image = Image.create(:filename => filename)
        @q.answers << @a
      end
      quiz.questions << @q
    end
  end

  def edit_questions_and_answers(hash,quiz)
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
  end

end
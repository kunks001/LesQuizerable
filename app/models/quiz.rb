class Quiz

	include DataMapper::Resource

	has n, :questions, :through => Resource, constraint: :destroy

	property :id, Serial
  property :title, String

  def upload(value)
    file  = value["file"][:tempfile]
    filename = value["file"][:filename]
    ApplicationHelper::upload(file, filename)
  end


  def save_questions_and_answers(hash,quiz)
    hash.each do |key, value|
      text = value["question_text"]
      @q = Question.new(question_text: text)
      if value["file"]
        upload(value)
        @q.image = Image.create(:filename => value["file"][:filename])
      end
      answers = value["answer"]
      answers.each do |key, value|
        r = value["response"]
        value["correctness"] == "on" ? c = true : c = false
        @a = Answer.new(:response => r, :correctness => c)
        if value["file"]
          upload(value)
          @a.image = Image.create(:filename => value["file"][:filename])
        end
        @q.answers << @a
      end
      quiz.questions << @q
    end
  end

  def edit_questions_and_answers(hash,quiz)
    hash.each do |key, value|
      text = value["question_text"]
      @q = Question.get(key.to_i)
      @q.update(:question_text => text)
      if value["file"]
        file  = value["file"][:tempfile]
        filename = value["file"][:filename]
        ApplicationHelper::upload(file, filename)
        if @q.image
       		@q.image.update(:filename => filename)
       	else
       		@q.image = Image.create(:filename => filename)
       	end
      end
      if @q.save
	      answers = value["answer"]
	      answers.each do |key, value|
	        @answer = Answer.get(key.to_i)
	        r = value["response"]
	        if value["file"]
	          file  = value["file"][:tempfile]
	          filename = value["file"][:filename]
	          ApplicationHelper::upload(file, filename)
	          if @answer.image
	            @answer.image.update(:filename => filename)
	            @answer.save
	            @answer.update(:response => r)
	          else
	            @answer.image = Image.create(:filename => filename)
	            @answer.save
	            @answer.update(:response => r)
	          end
	        end
	      end
	    else
	    	puts "failure!"
	    end
    end
  end

end
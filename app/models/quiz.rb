class Quiz

	include DataMapper::Resource

	has n, :questions, :through => Resource, constraint: :destroy

	property :id, Serial
  property :title, String

  def upload_image(value)
    file  = value["file"][:tempfile]
    filename = value["file"][:filename]
    ApplicationHelper::upload(file, filename)
  end

  def create_image(object,value)
    upload_image(value)
    object.image = Image.create(:filename => value["file"][:filename])
  end

  def correct?(value)
    value == "on" ? c = true : c = false
  end

  def create_answers(q,answers)
    answers.each do |key, value|
      correctness = correct?(value[:correctness])
      a = Answer.new(:response => value["response"], :correctness => correctness)
      create_image(a,value) if value["file"]
      q.answers << a
    end
  end

  def save_questions_and_answers(hash,quiz)
    hash.each do |key, value|
      q = Question.new(question_text: value["question_text"])
      create_image(q,value) if value["file"]
      create_answers(q,value["answer"])
      quiz.questions << q
    end
  end

  def edit_questions_and_answers(hash,quiz)
    hash.each do |key, value|
      @q = Question.get(key.to_i)
      @q.update(:question_text => value["question_text"])
      if value["file"]
        upload_image(value)
        if @q.image
       		@q.image.update(:filename => filename)
       	else
       		@q.image = Image.create(:filename => value["file"][:filename])
       	end
      end
      if @q.save
	      answers = value["answer"]
	      answers.each do |key, value|
	        @answer = Answer.get(key.to_i)
	        r = value["response"]
	        if value["file"]
	          upload_image(value)
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
class Quiz

  include DataMapper::Resource

  has n, :questions, :through => Resource, constraint: :destroy

  property :id, Serial
  property :title, String
  property :displayed, Boolean, :default => false

  def correct_answer_ids
    questions.map { |q| q.correct_answer.first.id }
  end

  def show_on_homepage(quizzes)
    quizzes.select { |q| q.displayed == true }.each {|q| q.update(displayed: false); q.save}
    self.update(displayed: true); self.save
  end

  def take_off_homepage
    self.update(displayed: false); self.save
  end

  def add_questions(questions, quiz)
    questions.each do |key, value|
      next if value["question_text"] == ""

      question_text = value["question_text"]
      image         = value["file"]
      answers       = value["answer"]

      question = Question.new(question_text: question_text)

      question.add_image(image) if image
      question.add_answers(answers)
      quiz.questions << question
    end
  end

  def edit_questions(hash,quiz)
    hash.each do |key, value|
      question        = Question.get(key.to_i)
      question_text   = value["question_text"]
      image           = value["file"]
      answers         = value["answer"]

      ImageUpdateHelper::update_image(question, image) if image
      question.update(:question_text => question_text) if question.save
      question.update_answers(answers) if question.save
    end
  end
end
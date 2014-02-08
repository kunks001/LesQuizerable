class Question

  include DataMapper::Resource

  has 1, :quiz,    :through => Resource
  has 1, :image, :through => Resource, constraint: :destroy
  has n, :answers, :through => Resource, constraint: :destroy

  property :id, Serial
  property :question_text, Text

  def correct_answer
    answers.select { |a| a.correctness }
  end

  def add_answers(answers)
    answers.each do |key, value|
      next if value["response"] == ""

      correctness = value[:correctness]
      image = value["file"]
      response = value["response"]

      answer = Answer.new(:response => response, 
                          :correctness => check(correctness))
      answer.add_image(image) if image
      self.answers << answer
    end
  end

  def add_image(image)
    ImageUploadHelper::create_image(self, image)
  end

  def check(correctness)
    correctness == "on" ? true : false
  end

  def update_answers(answers)
    answers.each do |key, value|
      image = value["file"]

      answer = Answer.get(key.to_i)
      answer.update(:response => value["response"])
      ImageUpdateHelper::update_image(answer, image) if image
    end
  end
end
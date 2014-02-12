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
    if answers
      answers.each do |key, value|
        next if value["response"] == ""

        correctness = check(value["correctness"])
        image = value["file"]
        response = value["response"]

        answer = Answer.new(:response => response, 
                            :correctness => correctness)
        answer.add_image(image) if image
        self.answers << answer
      end
    end
  end

  def add_image(image)
    ImageUploadHelper::create_image(self, image)
  end

  def check(correctness)
    correctness == "yes"  ? true : false
  end

  def update_answers(answers)
    if answers
      answers.each do |key, value|
        image = value["file"]

        answer = Answer.get(key.to_i)
        ImageUpdateHelper::update_image(answer, image) if image
        answer.update(:response => value["response"]) if answer.save
      end
    end
  end
end
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
      correctness = correct?(value[:correctness])
      a = Answer.new(:response => value["response"], :correctness => correctness)
      ImageUploadHelper::create_image(a,value["file"]) if value["file"]
      self.answers << a
    end
  end

  def add_image(image)
    ImageUploadHelper::create_image(self, image)
  end

  def correct?(value)
    value == "on" ? c = true : c = false
  end

  def update_answers(answers)
    answers.each do |key, value|
      answer = Answer.get(key.to_i)
      answer.update(:response => value["response"])
      upload_and_update_image(answer, value["file"]) if value["file"]
    end
  end


  def update_image(value)
    if self.image
      ImageUploadHelper::prepare_and_upload_image(value)
      self.image.update(:filename => value[:filename])
    else
      self.image = Image.create(:filename => value[:filename])
    end
  end

  def upload_and_update_image(answer,value)
    ImageUploadHelper::prepare_and_upload_image(value)
    if answer.image
      answer.image.update(:filename => value[:filename])
    else
      answer.image = Image.create(:filename => value[:filename])
    end
  end
end
class Question

	include DataMapper::Resource

	has 1, :quiz, 	:through => Resource
	has n, :answers, :through => Resource

	property :id, Serial
  property :question_text, Text

end
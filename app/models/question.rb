class Question

	include DataMapper::Resource

	has 1, :quiz, 	:through => Resource

	property :id, Serial
  property :question_text, Text

end
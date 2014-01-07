class Question

	include DataMapper::Resource

	has 1, :quiz, 	:through => Resource
	has n, :answers, :through => Resource, constraint: :destroy

	property :id, Serial
  property :question_text, Text

end
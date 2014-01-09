class Question

	include DataMapper::Resource

	has 1, :quiz, 	 :through => Resource
	has 1, :image, :through => Resource, constraint: :destroy
	has n, :answers, :through => Resource, constraint: :destroy

	property :id, Serial
  property :question_text, Text

end
class Answer

	include DataMapper::Resource

	has 1, :question, 	:through => Resource
	has 1, :image, 	:through => Resource

	property :id, Serial
  property :response, Text
  property :correctness, Boolean, :default  => false

end
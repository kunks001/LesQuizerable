class Image

	include DataMapper::Resource

	has 1, :question, :through => Resource
	has 1, :answer, 	:through => Resource

	property :id, Serial
  property :filename, String

end
class Quiz

	include DataMapper::Resource

	has n, :questions, :through => Resource

	property :id, Serial
  property :title, String

end
class Quiz

	include DataMapper::Resource

	has n, :questions, :through => Resource, constraint: :destroy

	property :id, Serial
  property :title, String

end
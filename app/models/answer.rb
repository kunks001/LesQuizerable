class Answer

  include DataMapper::Resource

  has 1, :question,   :through => Resource
  has 1, :image,  :through => Resource,  constraint: :destroy

  property :id, Serial
  property :response, Text
  property :correctness, Boolean, :default  => false

  def add_image(image)
    ImageUploadHelper::create_image(self, image)
  end

end

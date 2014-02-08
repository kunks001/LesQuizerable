module ImageUpdateHelper
	class << self
		def update_image(object,value)
	    ImageUploadHelper::prepare_and_upload_image(value)
	    if object.image
	      object.image.update(:filename => value[:filename])
	    else
	      object.image = Image.create(:filename => value[:filename])
	    end
	  end
	end
end
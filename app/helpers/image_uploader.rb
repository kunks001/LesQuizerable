module ImageUploadHelper  
  class << self
    def create_image(object,value)
      prepare_and_upload_image(value)
      object.image = Image.create(:filename => value[:filename])
    end

    def prepare_and_upload_image(value)
      file  = value[:tempfile]
      filename = value[:filename]
      upload(file, filename)
    end

    def upload(file,filename)
      bucket     = 'MakersQuizApp'
      AWS::S3::Base.establish_connection!(
        :access_key_id     => ENV['AWS_KEY'],
        :secret_access_key => ENV['AWS_SECRET']
      )
      ok_response = AWS::S3::S3Object.store(
        filename,
        open(file.path),
        bucket,
        :access => :public_read
      ).response
      ok_response
    end 
  end
end
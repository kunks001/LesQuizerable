module ImageUploadHelper  
  class << self 
    def upload(file,filename)
      awskey     = QuizApp.settings.access_key_id
      awssecret  = QuizApp.settings.secret_access_key
      bucket     = 'MakersQuizApp'
      AWS::S3::Base.establish_connection!(
        :access_key_id     => awskey,
        :secret_access_key => awssecret
      )
      ok_response = AWS::S3::S3Object.store(
        filename,
        open(file.path),
        bucket,
        :access => :public_read
      ).response
      ok_response
    end

    def prepare_and_upload_image(value)
      file  = value["file"][:tempfile]
      filename = value["file"][:filename]
      upload(file, filename)
    end
  end
end
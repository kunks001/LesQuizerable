module ApplicationHelper

  def current_admin    
    @current_admin ||= Admin.get(session[:admin_id]) if session[:admin_id]
  end

  def editable_by_admin_with(id)
    (current_admin.super_admin? || (current_admin.id == id.to_i))
  end

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
  end
end
module ApplicationHelper

  def current_admin    
    @current_admin ||= Admin.get(session[:admin_id]) if session[:admin_id]
  end

  def update_admin(user,email,password,password_confirmation)
    if (password == "") && (email == "")
    elsif (password == "") && (email != "")
      user.update(:email => email)
    elsif (password != "") && (email == "")
      user.update(:password => password,
                  :password_confirmation => password_confirmation)
    else
      user.update(:email => email, 
                  :password => password,
                  :password_confirmation => password_confirmation)
    end
  end

  def upload(file,filename)
    awskey     = settings.access_key_id
    awssecret  = settings.secret_access_key
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
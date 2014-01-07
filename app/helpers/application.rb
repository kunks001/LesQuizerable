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

end
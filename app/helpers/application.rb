module ApplicationHelper

  def current_admin    
    @current_admin ||= Admin.get(session[:admin_id]) if session[:admin_id]
  end

end
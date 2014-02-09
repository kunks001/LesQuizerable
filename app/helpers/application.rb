module ApplicationHelper

  def current_admin    
    @current_admin ||= Admin.get(session[:admin_id]) if session[:admin_id]
  end

  def editable_by_admin_with(id)
    (current_admin.super_admin? || (current_admin.id == id.to_i))
  end

  def flash_types
    [:success, :notice, :warning, :error]
  end

end
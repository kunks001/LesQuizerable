def admin_details
  @admin_details ||=  { :email => 'example@example.com',
                        :password => 'foobar',
                        :password_confirmation => 'foobar'
                      }
end

def delete_admin
  @admin ||= Admin.first(:email => admin_details[:email])
  @admin.destroy unless @admin.nil?
end

def create_admin(info = admin_details)
  @admin ||= FactoryGirl.create(:admin, info)
end

def sign_in
  visit '/sessions/new'
  within ('#sign-in-form') do
    fill_in 'email', with: admin_details[:email]
    fill_in 'password', with: admin_details[:password]
    click_button 'Sign in'
  end
end

def clear_user_session
  page.driver.submit :delete, '/sessions', {}
end
  
def path_to(page_name, id = '')
  name = page_name.downcase
  case name
    when 'home' then
      ''
    when 'signin' then
      '/sessions/new'
    when 'edit' then
      "/admins/#{id}/edit"
    when 'new quiz' then
      '/quizzes/new'
    when 'quizzes' then
      '/quizzes'
    else
      raise('path to specified is not listed in #path_to')
  end
end

def with_scope(locator)
  locator ? within(*selector_for(locator)) { yield } : yield
end

def selector_for(locator)
  case locator
    when "Edit profile" then
      return 'form#edit-details'
    else
      raise "Can't find mapping from \"#{locator}\" to a selector.\n" +
            "Now, go and add a mapping in #{__FILE__}"
  end
end
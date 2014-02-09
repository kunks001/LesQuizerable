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

def create_admin(admin_details)
  FactoryGirl.create(:admin, admin_details)
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
  
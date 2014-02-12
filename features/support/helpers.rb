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

def create_quiz
  @quiz ||= FactoryGirl.create(:quiz)
end

def create_question(info = quiz_details)
  @quiz ||= FactoryGirl.create(:question, info)
end

def with_scope(locator)
  locator ? within(*selector_for(locator)) { yield } : yield
end

def attach_(image)
  case image
    when 'question-image.jpg' then
      attach_file('file', File.join(File.dirname(__FILE__), "/images/#{image}"))
    when 'answer-image.jpg' then
      attach_file('answer_image_0', File.join(File.dirname(__FILE__), "/images/#{image}"))
    when 'edited-question-image.jpg' then
      attach_file('file', File.join(File.dirname(__FILE__), "/images/#{image}"))
    when'edited-answer-image.jpg' then
      within(page.all(:css, '.answer_fields')[0]) do
      attach_file('answer_image_0', File.join(File.dirname(__FILE__), "/images/#{image}"))
    end
  end
end
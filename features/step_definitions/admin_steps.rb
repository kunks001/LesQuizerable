### GIVEN ###

Given(/^I am not signed up to the site$/) do
  delete_admin 
end

Given(/^I am a site admin$/) do
  create_admin(admin_details)
end

Given(/^I am not signed in$/) do
  clear_user_session
end

Given(/^I am signed in$/) do
  sign_in
end

Given(/^I am on the "([^"]*)" page$/) do |page|
  create_admin
  id = @admin.id
  visit path_to(page, id)
end

Given(/^I fill in "(.*?)" with:$/) do |name, table|
  with_scope(name) do
    table.rows.each do |row|
      fill_in row[0], with: row[1]
    end
  end
end

Given(/^I fill in the new quiz form with:$/) do |table|
  data = table.rows.flatten
  answers = page.all(:css, '.answer_text')

  fill_in 'title', with: data[0]
  fill_in 'question_text', with: data[1]
  page.all(:css, '.answer_text')[0].set(data[2])
  page.all(:css, '.answer_text')[1].set(data[3])
  page.all(:css, '.answer_text')[2].set(data[4])
end

Then(/^I should see a form "(.*?)" with:$/) do |name, table|
  with_scope(name) do
    table.rows.each do |row|
      page.should have_content row[0]
    end
  end
end


### WHEN ###

When(/^I sign in with valid credentials$/) do
  sign_in
end

When(/^I return to the site$/) do
  visit '/sessions/new'
end

When(/^I sign in with an invalid password$/) do
  create_admin(admin_details) 
  @admin_details = @admin_details.merge(:password => 'wrongpassword')
  sign_in
end

When(/^I sign in with an invalid email$/) do
  create_admin(admin_details)
  @admin_details = @admin_details.merge(:email => 'invalidemail')
  sign_in
end

When(/^I sign out$/) do
  click_button 'Sign out'
end

When(/^I click the "(.*?)" button$/) do |button|
  click_button button
end

### THEN ###

Then(/^I should see an invalid login message$/) do
  page.should have_content "The email or password are incorrect"
end

Then(/^I should be signed out$/) do
  page.should have_button "Sign in"
  page.should_not have_button "Sign out"
end

Then(/^I should see a successful sign in message$/) do
  page.should have_content "Signed in successfully."
end

Then(/^should be signed in$/) do
  page.should have_link 'Quizzes' || 'Dashboard'
end

Then(/^I should see a sign out confirmation message$/) do
  page.should have_content "Signed out successfully"
end

Then(/^I should see "(.*?)"$/) do |content|
  page.should have_content content
end

Then(/^I should be on the "(.*?)" page$/) do |page|
  id = @admin.id
  path_to(page, id).should include current_path
end



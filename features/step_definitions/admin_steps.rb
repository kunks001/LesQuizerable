### GIVEN ###

Given(/^that I am not signed up to the site$/) do
  delete_admin 
end

Given(/^that I am a site admin$/) do
  create_admin(admin_details)
end

Given(/^I am not signed in$/) do
  clear_user_session
end


### WHEN ###

When(/^I sign in with valid credentials$/) do
  sign_in
end

When(/^I return to the site$/) do
  visit '/sessions/new'
end

When(/^I sign in with an invalid password$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I sign in with an invalid email$/) do
  pending # express the regexp above with the code you wish you had
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



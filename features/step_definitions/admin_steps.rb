When(/^I sign up as Srik$/) do
  fill_in 'email', with: 'srik@srik.com'
  fill_in 'password', with: 'foobar12'
  fill_in 'password_confirmation', with: 'foobar12'
  click_button 'create_admin'
end

Given(/^I am on the 'create admin' page$/) do
  visit '/admin/create-admin'
end

Then(/^I should see "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code y`ou wish you had
end

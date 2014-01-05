When(/^I sign up as Srik$/) do
  click_link "Sign Up"
  fill_in 'email', with: 'srik@srik.com'
  fill_in 'password', with: 'foobar12'
  fill_in 'password_confirmation', with: 'foobar12'
  click_button 'sign_up'
end
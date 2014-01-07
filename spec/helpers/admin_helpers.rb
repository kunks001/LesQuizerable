module AdminHelpers

	def sign_in(email, password)
	  visit '/sessions/new'
	  fill_in 'email', :with => email
	  fill_in 'password', :with => password
	  click_button 'Sign in'
	end

	def sign_up(email = "alice@example.com", 
              password = "oranges!",
              password_confirmation = "oranges!")
	  visit '/admins/new'
    fill_in :email, :with => email
    fill_in :password, :with => password
    fill_in :password_confirmation, :with => password_confirmation
    click_button "Submit"
  end

  def reset_session
  	visit '/reset-session'
  end
end
require 'spec_helper'

feature "editing Admins" do

	before(:each) do
    Admin.create(:email => "test@test.com", 
                :password => 'test', 
                :password_confirmation => 'test')
  end

  scenario "when not logged in" do
  	visit '/admins/1'
  	expect(page.current_path).to eq '/sessions/new'
  end

	scenario "when signed in as an admin" do
		sign_in('test@test.com', 'test')
		visit '/admins'
		click_link('Edit')
		expect(page).to have_content 'Edit Details'
		fill_in 'email', with: 'hamil@ton.com'
		click_button 'Submit'
		expect(current_path).to eq '/'
		expect(page).to have_content 'Your details have been successfully updated'
	end

end
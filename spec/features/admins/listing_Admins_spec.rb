require 'spec_helper'

feature "listing Admins" do

	before(:each) do
    Admin.create(:email => "test@test.com", 
                :password => 'test', 
                :password_confirmation => 'test')
    Admin.create(:email => "test-two@test.com", 
                :password => 'test', 
                :password_confirmation => 'test')
  end

  scenario "when not logged in" do
  	visit '/admins'
  	expect(page.current_path).to eq '/sessions/new'
  end

  scenario "when signed in as an admin" do
		sign_in('test@test.com', 'test')
		visit '/admins'
		expect(page).to have_content 'test@test.com'
		expect(page).to have_content 'test-two@test.com'
		expect(page).to have_css '.edit'
		expect(page).to have_css '.delete'
	end
end
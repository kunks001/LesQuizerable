require 'spec_helper'

feature "deleting an admin profile" do

  let!(:admin) { FactoryGirl.create(:admin) }
  let!(:super_admin) { FactoryGirl.create(:super_admin) }

  after(:each) do
    reset_session
  end

  scenario "when logged in as an admin" do
  	sign_in('test@test.com', 'test')
  	visit '/admins'
  	expect(page).to_not have_css '.delete'
	end

	scenario "when logged in as a super admin" do
		sign_in('foo@bar.com', 'foobar')
		visit '/admins'
		first('.delete').click_button 'Delete'
		expect(current_path).to eq '/admins'
		expect(page).to_not have_content 'test@test.com'
	end


end
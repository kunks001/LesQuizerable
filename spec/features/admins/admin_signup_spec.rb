require 'spec_helper'

feature "Creating a new admin" do
  
  scenario "when logged out" do
    visit '/admins/create-admin'
    expect(current_path).to eq '/sessions/new'        
  end

  context "when logged in" do

    before(:each) do
      FactoryGirl.create(:admin)
      sign_in('test@test.com','foobar')
    end

    after(:each) do
      reset_session
    end

    scenario "with a password that doesn't match" do
      lambda { sign_up('a@a.com', 'pass', 'wrong') }.should change(Admin, :count).by(0)
      expect(current_path).to eq('/admins/new')   
      expect(page).to have_content("Password does not match the confirmation")
    end

    scenario "with an email that is already registered" do    
      lambda { sign_up }.should change(Admin, :count).by(1)
      lambda { sign_up }.should change(Admin, :count).by(0)
      expect(page).to have_content("The email you have entered is already taken")
    end
  end

end
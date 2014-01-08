require 'spec_helper'

feature "Creating a new admin" do

  before(:each) do
    FactoryGirl.create(:admin)
  end

  after(:each) do
    reset_session
  end
  
  scenario "when logged out" do
    visit '/admins/new'
    expect(current_path).to eq '/sessions/new'        
  end

  ### TODO: refactor signin lambda duplicates

  scenario "when logged in" do
    sign_in('test@test.com','foobar')  
    lambda { sign_up }.should change(Admin, :count).by(1)
  end

  scenario "when logged in, but with a password that doesn't match" do
    sign_in('test@test.com','foobar')
    lambda { sign_up('a@a.com', 'pass', 'wrong') }.should change(Admin, :count).by(0)
    expect(current_path).to eq('/admins/new')   
    expect(page).to have_content("Password does not match the confirmation")
  end

  scenario "when logged in, with an email that is already registered" do 
    sign_in('test@test.com','foobar')   
    lambda { sign_up }.should change(Admin, :count).by(1)
    lambda { sign_up }.should change(Admin, :count).by(0)
    expect(page).to have_content("The email you have entered is already taken")
  end

end
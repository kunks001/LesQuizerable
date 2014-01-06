require 'spec_helper'

feature "Admin signs up" do
  
  scenario "when being logged out" do    
    lambda { sign_up }.should change(Admin, :count).by(1)    
    expect(page).to have_content("Welcome, alice@example.com")
    expect(Admin.first.email).to eq("alice@example.com")      
  end

  scenario "with a password that doesn't match" do
    lambda { sign_up('a@a.com', 'pass', 'wrong') }.should change(Admin, :count).by(0)
    expect(current_path).to eq('/admin/create-admin')   
    expect(page).to have_content("Sorry, your passwords don't match")
  end

  scenario "with an email that is already registered" do    
    lambda { sign_up }.should change(Admin, :count).by(1)
    lambda { sign_up }.should change(Admin, :count).by(0)
    expect(page).to have_content("This email is already taken")
  end

  def sign_up(email = "alice@example.com", 
              password = "oranges!",
              password_confirmation = "oranges!")
    visit '/admin/create-admin'
    fill_in :email, :with => email
    fill_in :password, :with => password
    fill_in :password_confirmation, :with => password_confirmation
    click_button "Create Admin"
  end

end
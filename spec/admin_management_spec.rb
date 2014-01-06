require 'spec_helper'

feature "Admin signs up" do
  
  scenario "when being logged out" do    
    lambda { sign_up }.should change(Admin, :count).by(1)    
    expect(page).to have_content("Welcome, alice@example.com")
    expect(Admin.first.email).to eq("alice@example.com")        
  end

  def sign_up(email = "alice@example.com", 
              password = "oranges!")
    visit '/admin/create-admin'
    fill_in :email, :with => email
    fill_in :password, :with => password
    click_button "Create Admin"
  end

end
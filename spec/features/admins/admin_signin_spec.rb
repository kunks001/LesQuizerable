require 'spec_helper'

feature "Admin signs in" do

  before(:each) do
    Admin.create(:email => "test@test.com", 
                :password => 'test', 
                :password_confirmation => 'test')
  end

  after(:each) do
    reset_session
  end

  scenario "with correct credentials" do
    visit '/'
    expect(page).not_to have_content("Welcome, test@test.com")
    sign_in('test@test.com', 'test')
    expect(page).to have_content("Welcome, test@test.com")
  end

  scenario "with incorrect credentials" do
    visit '/'
    expect(page).not_to have_content("Welcome, test@test.com")
    sign_in('test@test.com', 'wrong')
    expect(page).not_to have_content("Welcome, test@test.com")
  end

end
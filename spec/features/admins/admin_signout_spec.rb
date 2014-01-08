require 'spec_helper'

feature 'Admin signout' do

  before(:each) do
    FactoryGirl.create(:admin)
  end

  after(:each) do
    reset_session
  end

  scenario 'while signed in' do
    sign_in('test@test.com', 'foobar')
    click_button "Sign out"
    expect(page).to have_content("Good bye!")
    expect(page).not_to have_content("Welcome, test@test.com")
  end

end
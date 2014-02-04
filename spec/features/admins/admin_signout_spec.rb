require 'spec_helper'

feature 'Admin signout' do

  let!(:admin) { FactoryGirl.create(:admin) }

  after(:each) do
    reset_session
  end

  scenario 'while signed in' do
    sign_in('test@test.com', 'foobar')
    click_button "Sign out"
    expect(page).to have_content("Please sign in")
    expect(page).not_to have_content("Welcome, test@test.com")
  end

end
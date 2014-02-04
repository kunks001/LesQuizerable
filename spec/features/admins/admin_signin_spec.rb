require 'spec_helper'

feature "Admin signin" do

  let!(:admin) { FactoryGirl.create(:admin) }

  after(:each) do
    reset_session
  end

  scenario "with correct credentials" do
    visit '/'
    expect(page).not_to have_content("Welcome, test@test.com")
    sign_in('test@test.com', 'foobar')
    expect(page.current_path).to eq '/quizzes'
  end

  scenario "with incorrect credentials" do
    visit '/'
    expect(page).not_to have_content("Welcome, test@test.com")
    sign_in('test@test.com', 'wrong')
    expect(page).not_to have_content("Welcome, test@test.com")
  end

end
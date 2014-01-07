require 'spec_helper'

feature "listing Quizzes" do

  before(:each) do
    FactoryGirl.create(:quiz)
    Admin.create(:email => "test@test.com", 
                :password => 'foobar', 
                :password_confirmation => 'foobar')
  end

  after(:each) do
    reset_session
  end

  scenario "when not logged in" do
    visit '/quizzes'
    expect(page.current_path).to eq '/sessions/new'
  end

  scenario "when signed in as an admin" do
    sign_in('test@test.com', 'foobar')
    visit '/quizzes'
    expect(page).to have_content 'Example Quiz'
    expect(page).to have_content 'Example Question'
    expect(page).to have_content 'correct answer'
    expect(page).to have_content 'wrong answer'
    expect(page).to have_css '.edit'
    expect(page).to have_css '.delete'
  end
end
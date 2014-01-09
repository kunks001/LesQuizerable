require 'spec_helper'

feature "listing Quizzes" do

  let!(:admin) { FactoryGirl.create(:admin) }
  let!(:quiz) { FactoryGirl.create(:quiz) }

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
    expect(page).to have_css '.edit'
    expect(page).to have_button 'Delete Quiz'
  end
end
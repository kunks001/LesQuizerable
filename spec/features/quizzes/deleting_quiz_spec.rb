require 'spec_helper'

feature 'deleting a quiz' do

  let!(:admin) { FactoryGirl.create(:admin) }
  let!(:quiz) { FactoryGirl.create(:quiz) }

  after(:each) do
    reset_session
  end
  
  scenario 'when signed in' do
    sign_in("test@test.com", "foobar")
    visit '/quizzes'
    click_button "Delete Quiz"
    expect(current_path).to eq '/quizzes'
    expect(page).to_not have_content 'Example Quiz'
    expect(page).to_not have_content 'Example Question'
    expect(page).to_not have_content 'correct answer'
  end

end
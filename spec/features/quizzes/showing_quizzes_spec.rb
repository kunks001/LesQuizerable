require 'spec_helper'

feature 'showing a quiz' do

  let!(:admin) { FactoryGirl.create(:admin) }
  let!(:quiz) { FactoryGirl.create(:quiz) }

  after(:each) do
    reset_session
  end
  
  scenario 'when signed in' do
    sign_in('test@test.com', 'foobar')
    visit '/quizzes'
    click_link 'Example Quiz'
    expect(current_path).to match /quizzes\/[\d]/
    expect(page).to have_content 'Example Quiz'
    expect(page).to have_content 'Example Question'
    expect(page).to have_content 'correct answer'
    expect(page).to have_content 'wrong answer'
  end

end
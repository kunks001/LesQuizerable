require 'spec_helper'

feature "Making a new Quiz" do

  let!(:admin) { FactoryGirl.create(:admin) }

  after(:each) do
    reset_session
  end
  
  scenario "when logged out" do
    visit '/quizzes/new'
    expect(current_path).to eq '/sessions/new'        
  end

  scenario "with correct information' page" do
    sign_in('test@test.com', 'foobar')
    visit '/quizzes/new'
    expect(page).to have_content 'New Quiz'
    fill_in 'title', :with => 'Awesome Quiz!'
    first('.question').fill_in '[question][0][question_text]', :with => 'Great question'
    first('.answer').fill_in '[question][0][answer][0][response]', :with => 'Great answer'
    click_button 'Submit'

    expect(current_path).to eq '/quizzes'
    expect(page).to have_content 'Awesome Quiz!'
  end
end
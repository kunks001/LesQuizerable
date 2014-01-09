require 'spec_helper'

feature 'editing a quiz' do

  let!(:admin) { FactoryGirl.create(:admin) }
  let!(:quiz) { FactoryGirl.create(:quiz) }

  after(:each) do
    reset_session
  end

  scenario 'when signed out' do
    visit 'quizzes/:id/edit'
    expect(current_path).to eq '/sessions/new'
  end

## SET config.order = 'default' so id numbers wouldn't change and test
## would stay constant

  scenario 'when signed in' do
    sign_in("test@test.com", "foobar")
    visit '/quizzes'
    click_link 'Edit'
    expect(page).to have_content 'Edit Quiz'
    fill_in 'title', :with => 'Awesome Quiz!'
    first('.question').fill_in '[question][3][question_text]', :with => 'Great question'
    first('.answer').fill_in '[question][3][answer][10][response]', :with => 'Great answer'
    click_button 'Submit'
    expect(current_path).to eq '/quizzes'
    click_link 'Awesome Quiz!'
    expect(page).to have_content 'Awesome Quiz!'
    expect(page).to have_content 'Great question'
    expect(page).to have_content 'answer'
  end
  
end
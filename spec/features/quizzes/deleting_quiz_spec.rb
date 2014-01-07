require 'spec_helper'

feature 'deleting a quiz' do

  before(:each) do
    FactoryGirl.create(:admin)
    FactoryGirl.create(:quiz)
  end
  
  scenario 'when signed in' do
    sign_in("foo@bar.com", "foobar")
    visit '/quizzes'
    click_button 'Delete'
    expect(page).current_path.to eq '/quizzes'
    expect(page).to_not have_content 'Example Quiz'
    expect(page).to_not have_content 'Example Question'
    expect(page).to_not have_content 'correct answer'
  end

end
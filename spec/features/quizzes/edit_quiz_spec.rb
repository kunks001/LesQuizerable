require 'spec_helper'

feature 'editing a quiz' do

	before(:each) do
		FactoryGirl.create(:admin)
		FactoryGirl.create(:quiz)
	end

	scenario 'when signed out' do
		visit 'quizzes/:id/edit'
		expect(current_path).to eq '/sessions/new'
	end

	scenario 'when signed in' do
		sign_in("foo@bar.com", "foobar")
		visit '/quizzes'
		click_link 'Edit'
		expect(page).to have_content 'Edit Quiz'
		fill_in 'title', :with => 'Awesome Quiz!'
    first('.question').fill_in '[question][0][question_text]', :with => 'Great question'
    first('.answer').fill_in '[question][0][answer][0][response]', :with => 'Great answer'
    click_button 'Submit'
    expect(current_path).to eq '/quizzes'
    expect(page).to have_content 'Awesome Quiz!'
    expect(page).to have_content 'Great question'
    expect(page).to have_content 'answer'
  end
end
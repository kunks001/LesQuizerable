require 'spec_helper'

feature "Making a new Quiz" do

	context "when logged out" do
  
	  scenario "should redirect the user to the signin page" do
	    visit '/quizzes/new'
	    expect(current_path).to eq '/sessions/new'        
	  end
	end

  context "when logged in" do

  	before(:each) do
    Admin.create(:email => "test@test.com", 
                :password => 'test', 
                :password_confirmation => 'test')
  	end

  	scenario "with correct information' page" do
  		sign_in('test@test.com', 'test')
  		visit '/quizzes/new'
  		expect(page).to have_content 'New Quiz'
      fill_in 'Title', :with => 'Awesome Quiz!'
      # first('.question').fill_in('question[0][question_text]'), :with => 'Great question'
      # first('.answer').fill_in('question[0][answer][1][response]'), :with => 'Great answer'
      click_button 'Submit'

      expect(current_path).to eq '/quizzes'
      expect(page).to have_content 'Awesome Quiz!'
	  end

  end
end
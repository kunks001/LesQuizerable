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

  	scenario "should be possible" do
  		sign_in('test@test.com', 'test')
  		visit '/quizzes/new'
  		expect(page).to have_content 'New Quiz'
	  end

  end
end
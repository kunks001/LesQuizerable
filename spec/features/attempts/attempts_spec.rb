require 'spec_helper'

feature "Attempts" do
  let(:admin) { FactoryGirl.create(:admin) }
  let(:quiz) { FactoryGirl.create(:quiz) }

  scenario 'when taking a quiz', js: true do
    sign_in("test@test.com","foobar")
    visit "/attempts/#{quiz.id}/new"
    choose 'correct answer'
    click_button 'Submit'
    expect(page).to have_content '100%'
  end
end
require 'spec_helper'

describe 'New Quiz page' do

  before { FactoryGirl.create(:admin) }

  context 'button' do

    before do 
      visit '/sessions/new'
      sign_in('foo@bar.com', 'foobar')
      visit '/quizzes/new' 
    end

    it "'remove answer' should remove the answer", :js => true do
      within(page.all(:css, '.answer_fields')[0]) do
        click_button 'Remove Answer'
      end
      expect(page).to have_css('.answer_fields', count: 2)
    end

    it "'remove question' should remove the answer", :js => true do
      within('.qa-fields') do
        click_button 'Remove Question'
      end
      expect(page).to have_css('.answer_fields', count: 0)
    end

  end

end
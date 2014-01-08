require 'spec_helper'

feature "editing admin profile" do

  before(:each) do
    FactoryGirl.create(:admin)
  end

  let!(:super_admin) {FactoryGirl.create(:super_admin)}

  after(:each) do
    reset_session
  end

  scenario "when logged out" do
    visit '/admins/1/edit'
    expect(page.current_path).to eq '/sessions/new'
  end

  scenario "which doesn't belong to logged in admin" do
    sign_in('test@test.com', 'foobar')
    visit('/admins/19/edit')
    expect(page.current_path).to eq '/sessions/new'
  end

  scenario "which belongs to logged in admin" do
    sign_in('test@test.com', 'foobar')
    visit '/admins'
    click_link('Edit')
    expect(page).to have_content 'Edit Details'
    fill_in 'email', with: 'hamil@ton.com'
    fill_in 'current_password', with: 'foobar'
    click_button 'Submit'
    expect(current_path).to eq '/'
    expect(page).to have_content 'Your details have been successfully updated'
  end

  scenario "which doesn't belong to a logged in super admin" do
    sign_in('foo@bar.com', 'foobar')
    visit '/admins'
    first('.edit').click_link('Edit')
  end

end
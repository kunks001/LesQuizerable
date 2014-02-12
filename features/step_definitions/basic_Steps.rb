### GIVEN ###

Given(/^I am on the "([^"]*)" page$/) do |page|
  visit path_to(page)
end

Given(/^I fill in "(.*?)" with:$/) do |name, table|
  with_scope(name) do
    table.rows.each do |row|
      fill_in row[0], with: row[1]
    end
  end
end

### WHEN ###

When(/^I return to the site$/) do
  visit '/sessions/new'
end

When(/^I click the "(.*?)" button$/) do |button|
  click_button button
end

When(/^I click the "(.*?)" link$/) do |link|
  click_link link
end

### THEN ###

Then(/^I should see "(.*?)"$/) do |content|
  page.should have_content content
end

Then(/^I should be on the "(.*?)" page$/) do |page|
  id = @admin.id
  path_to(page, id).should include current_path
end

Then(/^I should see a form "(.*?)" with:$/) do |name, table|
  with_scope(name) do
    table.rows.each do |row|
      page.should have_content row[0]
    end
  end
end

Then(/^I should see the image "(.*?)"$/) do |image|
  page.should have_xpath("//img[@src=\"https://s3.amazonaws.com/MakersQuizApp/#{image}\"]")
end
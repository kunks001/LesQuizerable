### GIVEN ###

Given(/^I fill in the new quiz form with:$/) do |table|
  data = table.rows.flatten
  answers = page.all(:css, '.answer_text')

  fill_in 'title', with: data[0]
  fill_in 'question_text', with: data[1]
  page.all(:css, '.answer_text')[0].set(data[2])
  page.all(:css, '.answer_text')[1].set(data[3])
  page.all(:css, '.answer_text')[2].set(data[4])
end

Given(/^Given I fill in the edit quiz form with:$/) do |table|
  data = table.rows.flatten
  answers = page.all(:css, '.answer_input')

  fill_in 'title', with: data[0]
  fill_in 'question_input', with: data[1]
  page.all(:css, '.answer_input')[0].set(data[2])
  page.all(:css, '.answer_input')[1].set(data[3])
  page.all(:css, '.answer_input')[2].set(data[4])
end

Given(/^a quiz already exists$/) do
  create_quiz
end

Given(/^I add the image "(.*?)"$/) do |image|
	attach_(image)
end

### WHEN ###

### THEN ###
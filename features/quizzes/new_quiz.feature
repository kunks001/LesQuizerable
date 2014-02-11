Feature: Creating quizzes
  To display quizzes on the home page
  As a site administrator
  I want to be able to create a quiz

  Background:
    Given I am a site admin
    And I am signed in
    And I am on the "new quiz" page

  Scenario: successfully creating a quiz
    Given I fill in the new quiz form with:
      | title    | question   | answer 1     | answer 2      | answer 3     |
      | New quiz | Question 1 | first answer | second answer | third answer |
    When I click the "Create Quiz!" button
    Then I should be on the "quizzes" page
    And I should see "Quiz created successfully!"
    And I should see "New quiz"
    When I click the "New quiz" link
    Then I should see "Question 1"
    And I should see "first answer"
    And I should see "second answer"
    And I should see "third answer"
Feature: Editing Quizzes
  To change an existing quiz
  As a site admin
  I want to be able to edit quizzes

  Background:
    Given I am a site admin
    And I am signed in
    And a quiz already exists
    And I am on the "edit_quiz" page

  Scenario: Editing a quiz
    Given Given I fill in the edit quiz form with:
      | title       | question     | answer 1   | answer 2   | answer 3   |
      | edited quiz | new question | new answer | new answer | new answer |
    When I click the "Submit" button
    Then I should be on the "quizzes" page
    And I should see "Quiz updated successfully!"
    And I should see "edited quiz"
    When I click the "edited quiz" link
    Then I should see "new question"
    And I should see "new answer"

  Scenario: Updating a quiz with pictures
    Given Given I fill in the edit quiz form with:
      | title       |
      | edited quiz |
    And I add the image "edited-question-image.jpg" 
    And I add the image "edited-answer-image.jpg"
    When I click the "Submit" button
    Then I should be on the "quizzes" page
    And I should see "Quiz updated successfully!"
    And I should see the image "edited-question-image.jpg"
    When I click the "edited quiz" link
    Then I should be on the "show quiz" page
    Then I should see the image "edited-question-image.jpg"
    And I should see the image "edited-answer-image.jpg"
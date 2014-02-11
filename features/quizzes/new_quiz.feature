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
      | title  | question   | answer 1     | answer 2      | answer 3     |
      | A quiz | Question 1 | first answer | second answer | third answer |
    When I click the "Create Quiz!" button
    Then I should be on the "quizzes" page
    And I should see "Quiz created successfully!"
    And I should see "A quiz"
    When I click the "A quiz" link
    Then I should see "Question 1"
    And I should see "first answer"
    And I should see "second answer"
    And I should see "third answer"

  Scenario: creating a picture quiz
    Given I fill in the new quiz form with:
      | title  | question   | answer 1     |
      | A quiz | question 1 | first answer |
    And I add the image "question-image.jpg" 
    And I add the image "answer-image.jpg"
    When I click the "Create Quiz!" button 
    Then I should see "Quiz created successfully!"
    And I should see the image "question-image.jpg"
    When I click the "A quiz" link
    Then I should see the image "question-image.jpg"
    And I should see the image "answer-image.jpg"
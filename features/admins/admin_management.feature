Feature: Editing my account
  To update my account settings
  As an existing admin
  I want to be able to edit my details

  Background:
    Given I am a site admin
    And I am signed in
    And I am on the "edit_admin" page

  Scenario: The edit page
    Then I should see "Edit Profile"
    And I should see a form "Edit profile" with:
      | Field                 |
      | Password              |
      | Password Confirmation |

  Scenario: Updating password
    Given I fill in "Edit profile" with:
      | Field                 | Text                |
      | password              | newpassword         |
      | password_confirmation | newpassword         |
    When I click the "Submit" button
    Then I should see "Your details have been successfully updated"

  Scenario: with passwords that don't match
    Given I fill in "Edit profile" with:
      | Field                 | Text                |
      | password              | newpassword         |
      | password_confirmation | differentpassword   |
    When I click the "Submit" button
    Then I should be on the "edit_admin" page
    Then I should see "Sorry, update failed. Please try again."

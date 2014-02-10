Feature: Editing my account
  In order to manage my account settings
  As I user I would like to have an account page page
  So I will be able to update my credentials

  Background:
	  Given I am a site admin
    And I am signed in
    And I am on the "edit" page

  Scenario: The edit page
    Then I should see "Edit Profile"
    And I should see a form "Edit profile" with:
      | Field                 |
      | Password							|
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
    Then I should be on the "edit" page
    Then I should see "Sorry, update failed. Please try again."

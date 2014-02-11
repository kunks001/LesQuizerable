Feature: Sign out
  To prevent unauthorized access to their account
  As a signed in user
  I want to be able to sign out

  Background:
    Given I am a site admin

  Scenario: User signs out
    Given I am signed in
    When I sign out
    Then I should see a sign out confirmation message
    When I return to the site
    Then I should be signed out
Feature: Sign in
  To access the dashboard
  As an existing admin
  So I want to be able to sign in

  Scenario: Admin is not signed up
    Given I am not signed up to the site
    When I sign in with valid credentials
    Then I should see an invalid login message
    And I should be signed out

  Scenario: Successful sign in
    Given I am a site admin
    And I am not signed in
    When I sign in with valid credentials
    Then I should see a successful sign in message
    When I return to the site
    Then should be signed in

  Scenario Outline: Admin enters wrong credentials
    Given I am a site admin
    And I am not signed in
    When I sign in with an invalid <credential>
    Then I should see an invalid login message
    And I should be signed out
  Examples:
    |credential|
    |password  |
    |email     |
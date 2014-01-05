Feature: logging is as an admin

Scenario: Signing up
	Given I am on the homepage
	When I sign up as Srik
	Then I should see "Logout"
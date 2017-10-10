Feature: Company registration
  As a company owner
  In order to find workers
  I would like to create an account

  Scenario: I register my company
    Given I am on the home page
    And I click "REGISTER"
    And I should see "REGISTER NEW USER"
    And I click "Company"
    And I fill in "Email" with "mail@mail.com"

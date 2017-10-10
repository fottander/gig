Feature: Company registration
  As a company owner
  In order to find workers
  I would like to create an account

  Scenario: I register my company
    Given I am on the home page
    And I click "REGISTER"
    And I should see "REGISTRATION"
    And I click "Company registration >"
    And I fill in "Email" with "mail@mail.com"
    And I fill in "Company name" with "hello"
    And I fill in "Address" with "gatan"
    And I fill in "Zip code" with "23122"
    And I fill in "City" with "Gbg"
    And I fill in "Org number" with "23423424"
    And I fill in "Phone" with "77387834"
    And I fill in "Password" with "12345678"
    And I fill in "Password confirmation" with "12345678"
    And I click "Sign up"
    And I should see "You have signed up successfully."

Feature: Company registration
  As a company owner
  In order to find workers
  I would like to create an account

  Background:
    Given the following companies exist
      | email          | name | username | address | zip_code | city | org_number | phone | password  | password_confirmation |
      | felix@mail.com | bill | anders p | gatan 3 | 53653643 | gbgb | 3453324533 | 98789 | 12345678  | 12345678              |

    Scenario: I register my company
      Given I am on the home page
      And I click "REGISTER"
      And I should see "REGISTER AS USER"
      And I click "Company registration >"
      And I fill in "Email" with "mail@mail.com"
      And I fill in "Company name" with "hello"
      And I fill in "Username" with "oij12"
      And I fill in "Address" with "gatan"
      And I fill in "Zip code" with "23122"
      And I fill in "City" with "Gbg"
      And I fill in "Org number" with "23423424"
      And I fill in "Phone" with "77387834"
      And I fill in "Password" with "12345678"
      And I fill in "Password confirmation" with "12345678"
      And I click "Sign up"
      Then I should see "You have signed up successfully."

    Scenario: I log in as a company
      Given I am on the home page
      And I click "LOGIN"
      And I click "Company login >"
      And I should see "Log in as company"
      And I fill in "Email" with "felix@mail.com"
      And I fill in "Password" with "12345678"
      And I click "Log in"
      Then I should see "Signed in successfully."

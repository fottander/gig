Feature: Company dashboard
  As a company user
  In order to structure my company info and jobs
  I would like to be able to have an account dasboard

  Background:
    Given the following companies exist
      | email          | name | address | zip_code | city | org_number | phone | password  | password_confirmation |
      | felix@mail.com | bill | gatan 3 | 53653643 | gbgb | 3453324533 | 98789 | 12345678  | 12345678              |

    Scenario: I go to dashboard
      Given I am on the home page
      And I click "LOGIN"
      And I click "Company login >"
      And I should see "Log in as company"
      And I fill in "Email" with "felix@mail.com"
      And I fill in "Password" with "12345678"
      And I click "Log in"
      Then I should see "Signed in successfully."
      And I should see "Company control panel"

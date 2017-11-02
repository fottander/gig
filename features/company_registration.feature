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
      And I click "REGISTRERA"
      And I should see "Registrera ny frilansare"
      And I click "Registrera företag >"
      And I fill in "Email" with "mail@mail.com"
      And I fill in "Företagsnamn" with "hello"
      And I fill in "Användarnamn" with "oij12"
      And I fill in "Adress" with "gatan"
      And I fill in "Postnummer" with "23122"
      And I fill in "Stad" with "Gbg"
      And I fill in "Organisationsnummer" with "23423424"
      And I fill in "Telefonnummer" with "77387834"
      And I fill in "Kontaktperson" with "Greger"
      And I fill in "Lösenord" with "12345678"
      And I fill in "Bekräfta lösenord" with "12345678"
      And I click "Registrera"
      Then I should see "You have signed up successfully."

    Scenario: I log in as a company
      Given I am on the home page
      And I click "LOGGA IN"
      And I click "Logga in företag >"
      And I should see "Logga in som företag"
      And I fill in "Email" with "felix@mail.com"
      And I fill in "Lösenord" with "12345678"
      And I click "Logga in"
      Then I should see "Signed in successfully."

Feature: Admin find companies
  As a system owner
  In order to manage the system
  I would like to be able to find companies

  Background:
    Given the following admins exist
      | email           | password  | password_confirmation |
      | admin@yahoo.com | 12345678  | 12345678              |
    Given the following companies exist
    | email          | name | username | address | zip_code | city | org_number | phone | password  | password_confirmation | id   |
    | felix@mail.com | bill | anders p | gatan 3 | 53653643 | gbgb | 3453324533 | 98789 | 12345678  | 12345678              | 9999 |
    | johan@mail.com | brag | johans p | gatan 3 | 53653643 | gbgb | 3453324533 | 98789 | 12345678  | 12345678              | 9998 |

    Scenario: I see companies and search by email
      Given I am logged in as admin "admin@yahoo.com"
      Given I am on the administrations page
      And I click "Företag"
      And I should see "Alla företag"
      And I should see "felix@mail.com"
      And I should see "johan@mail.com"
      And I fill in "with_email" with "felix@mail.com"
      And I click "Sök"
      Then I should see "felix@mail.com"
      And I should not see "johan@mail.com"
      And I click "Radera"
      And I should see "Företag raderat"
      Then I should not see "felix@mail.com"

    Scenario: I see companies and search by name
      Given I am logged in as admin "admin@yahoo.com"
      Given I am on the administrations page
      And I click "Företag"
      And I should see "Alla företag"
      And I fill in "with_name" with "brag"
      And I click "Sök"
      Then I should not see "felix@mail.com"
      And I should see "johan@mail.com"

    Scenario: I see companies and search by id
      Given I am logged in as admin "admin@yahoo.com"
      Given I am on the administrations page
      And I click "Företag"
      And I should see "Alla företag"
      And I fill in "with_id" with "9999"
      And I click "Sök"
      Then I should see "felix@mail.com"
      And I should not see "johan@mail.com"

    Scenario: I register company and then verify it as admin
      Given I am on the home page
      And I click "Hitta Personal"
      And I click "SKAPA KONTO"
      And I fill in "Email" with "mail@mail.com"
      And I fill in "Företagsnamn" with "hello"
      And I fill in "Användarnamn" with "oij12"
      And I fill in "Adress" with "gatan"
      And I fill in "Postnummer" with "23122"
      And I fill in "Stad" with "Gbg"
      And I fill in "Organisationsnummer" with "23423424"
      And I fill in "Telefonnummer" with "77387834"
      And I fill in "Lösenord" with "12345678"
      And I fill in "Bekräfta lösenord" with "12345678"
      And I click "Registrera"
      Then I should see "Snart klar! Aktivera ditt konto genom att följa instruktionerna i det bekräftelse email vi skickat till mail@mail.com."
      Given I am logged in as admin "admin@yahoo.com"
      Given I am on the administrations page
      And I click "Företag"
      And I should see "Alla företag"
      And I fill in "with_email" with "mail@mail.com"
      And I click "Sök"
      Then I should see "mail@mail.com"
      And I click "Verifiera"
      And I should see "Företag verifierat!"

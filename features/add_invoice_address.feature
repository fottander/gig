Feature: Invoice address
  As a company
  In order to get the invoices to the correct address
  I would like to be able to adjust the invoice address

  Background:
    Given the following companies exist
      | email          | name | username | address | zip_code | city     | org_number | phone | password  | password_confirmation | id |
      | felix@mail.com | bill | Anders p | gatan 3 | 53653643 | Göteborg | 3453324533 | 98789 | 12345678  | 12345678              | 1  |

  Scenario: I add invoice address
    Given I am logged in as company "felix@mail.com"
    Given I am on control panel page
    And I click "Konto"
    Then I should see "Redigera konto"
    And I fill in "Fakturaadress" with "BB redovisning, norrag.33, 42343, Göteborg"
    And I fill in "Nuvarande lösenord" with "12345678"
    And I click "Spara"
    Then I should see "Ditt konto har uppdaterats utan problem."

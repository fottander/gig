Feature: Edit company account
  As a company
  In order to get the most of my company account
  I would like to be able to edit and add extra information

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

  Scenario: I add employee count and description
    Given I am logged in as company "felix@mail.com"
    Given I am on control panel page
    Then I should see "Förbättra dina chanser genom att lägga till beskrivning"
    Then I should see "Förbättra dina chanser genom att ange antal anställda"
    And I click "Konto"
    Then I should see "Redigera konto"
    And I fill in "Beskrivning" with "Vi är ett litet företag i Vasastan"
    And I fill in "Nuvarande lösenord" with "12345678"
    And I click "Spara"
    Then I should see "Ditt konto har uppdaterats utan problem."
    Given I am on control panel page
    Then I should not see "Förbättra dina chanser genom att lägga till beskrivning"
    And I click "Konto"
    And I select "1-5" from "Antal anställda"
    And I fill in "Nuvarande lösenord" with "12345678"
    And I click "Spara"
    Then I should see "Ditt konto har uppdaterats utan problem."
    Given I am on control panel page
    Then I should not see "Förbättra dina chanser genom att ange antal anställda"

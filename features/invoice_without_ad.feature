Feature: Create an invoice without an ad
  As an user
  In order to get paid
  I would like to be able to create an invoice without being connected to an ad

  Background:
    Given the following categories exist
      | name        | id |
      | Målare      | 1  |
      | Snickare    | 2  |
      | Plåtslagare | 3  |
    Given the following cities exist
      | name      | id |
      | Göteborg  | 1  |
      | Stockholm | 2  |
      | Malmö     | 3  |
    Given the following companies exist
      | email           | name | username | address | zip_code | city     | org_number | phone | password  | password_confirmation | id |
      | greger@mail.com | bill | Anders p | gatan 3 | 53653643 | Göteborg | 3453324533 | 98789 | 12345678  | 12345678              | 1  |
    Given the following users exist
      | email          | password  | password_confirmation | id |
      | felix@mail.com | 12345678  | 12345678              | 1  |
      | greger@mail.com| 12345678  | 12345678              | 2  |
    Given the following profiles exist
      | username | title        | description | category_ids | city_ids | user_id | id |
      | Fisken   | 29 år målare | målare gbg  | 1            | 1        | 1       | 1  |

  Scenario: I create an invoice without an ad
    Given I am logged in as user "felix@mail.com"
    Given I am on the dashboards page
    And I click "Snabbfaktura"
    And I click "Skapa en faktura"
    Then I should see "Här kan du skapa fakturor som inte är direkt kopplade till en aktiv jobbannons"
    And I fill in "* Organisationsnummer" with "324234"
    And I fill in "* Företagsnamn" with "Kul ab"
    And I fill in "* Företagets adress" with "Södra"
    And I fill in "* Postnummer" with "423"
    And I fill in "* Stad" with "Gbg"
    And I fill in "* Email" with "felix@mail.com"
    And I fill in "* Företagsreferens" with "Erik"
    And I fill in "* Beskrivning" with "målning"
    And I fill in "* Summa" with "12323"
    And I fill in "* Referens" with "Roger"
    And I click "Skapa"
    Then I should see "Ny faktura skapad!"

  Scenario: I create an invoice without an ad but without a profile
    Given I am logged in as user "greger@mail.com"
    Given I am on the dashboards page
    And I click "Snabbfaktura"
    And I click "Skapa en faktura"
    Then I should see "Här kan du skapa fakturor som inte är direkt kopplade till en aktiv jobbannons"
    Then I should see "Skapa en profil innan du kan fakturera!"

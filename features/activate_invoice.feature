Feature: Activate job
  As a company user
  In order to receive my invoice
  I would like to be able to activate it

  Background:
    Given the following companies exist
      | email          | name | username | address | zip_code | city     | org_number | phone | password  | password_confirmation | id |
      | felix@mail.com | bill | Anders p | gatan 3 | 53653643 | Göteborg | 3453324533 | 98789 | 12345678  | 12345678              | 1  |
    Given the following users exist
      | email          | password  | password_confirmation | id |
      | felix@mail.com | 12345678  | 12345678              | 1  |
    Given the following invoices exist
      | description | amount | user_reference | terms | active | id | company_id | user_id |
      | abc         | 120    | felix          | 30    | false  | 1  | 1          | 1       |

    Scenario: I activate invoice
      Given I am logged in as company "felix@mail.com"
      Given I am on control panel page
      Then I should see "Faktura ID: 1"
      And I click "Visa"
      And I should see "abc"
      And I uncheck Terms check box
      And I click "Godkänn"
      And I should see "Faktura godkänd och aktiverad"
      And I should see "Status: Godkänd"
      And I should see "Villkor: 30 dagar"
      And I should see "Summa ex moms: 120 SEK"
      Then I should see "Summa att betala: 150 SEK"

    Scenario: I activate invoice with 60 days
      Given I am logged in as company "felix@mail.com"
      Given I am on control panel page
      Then I should see "Faktura ID: 1"
      And I click "Visa"
      And I should see "abc"
      And I check Terms check box
      And I click "Godkänn"
      And I should see "Faktura godkänd och aktiverad"
      And I should see "Status: Godkänd"
      Then I should see "Villkor: 60 dagar"
      And I should see "Summa att betala: 200 SEK"

    Scenario: I activate invoice with default terms
      Given I am logged in as company "felix@mail.com"
      Given I am on control panel page
      Then I should see "Faktura ID: 1"
      And I click "Visa"
      And I should see "abc"
      And I click "Godkänn"
      And I should see "Faktura godkänd och aktiverad"
      And I should see "Status: Godkänd"
      And I should see "Villkor: 30 dagar"
      Then I should see "Summa att betala: 150 SEK"

Feature: Activate job with post or email
  As a company user
  In order to receive my invoice in the proper way
  I would like to be able to activate it and setting email or postway

  Background:
    Given the following companies exist
      | email          | name | username | address | zip_code | city     | org_number | phone | password  | password_confirmation | id |
      | felix@mail.com | bill | Anders p | gatan 3 | 53653643 | Göteborg | 3453324533 | 98789 | 12345678  | 12345678              | 1  |
    Given the following invoices exist
      | description | amount | user_reference | terms | active | id | company_id |
      | abc         | 120    | felix          | 30    | false  | 1  | 1          |

    Scenario: I activate invoice with post
      Given I am logged in as company "felix@mail.com"
      Given I am on control panel page
      Then I should see "Faktura ID: 1"
      And I click "Visa"
      And I should see "abc"
      And I check Post check box
      And I click "Godkänn"
      And I should see "Faktura godkänd och aktiverad"
      And I should see "Status: Godkänd"
      And invoice "1" is sending by post
      Then I should see "Leveranssätt: Post"
      And I should see "Summa att betala: 620"

    Scenario: I activate invoice with email
      Given I am logged in as company "felix@mail.com"
      Given I am on control panel page
      Then I should see "Faktura ID: 1"
      And I click "Visa"
      And I should see "abc"
      And I uncheck Post check box
      And I click "Godkänn"
      And I should see "Faktura godkänd och aktiverad"
      And I should see "Status: Godkänd"
      Then I should see "Leveranssätt: Email"
      And I should see "Summa att betala: 120"

    Scenario: I activate invoice without specifying post or not
      Given I am logged in as company "felix@mail.com"
      Given I am on control panel page
      Then I should see "Faktura ID: 1"
      And I click "Visa"
      And I should see "abc"
      And I click "Godkänn"
      And I should see "Faktura godkänd och aktiverad"
      And I should see "Status: Godkänd"
      Then I should see "Leveranssätt: Email"
      And I should see "Summa att betala: 120"

    Scenario: I activate invoice with 60 days terms and post delivery
      Given I am logged in as company "felix@mail.com"
      Given I am on control panel page
      Then I should see "Faktura ID: 1"
      And I click "Visa"
      And I should see "abc"
      And I check Terms check box
      And I check Post check box
      And I click "Godkänn"
      And I should see "Faktura godkänd och aktiverad"
      And I should see "Status: Godkänd"
      And invoice "1" is sending by post
      Then I should see "Leveranssätt: Post"
      And I should see "Summa att betala: 660"

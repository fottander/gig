Feature: Admin find invoices
  As a system owner
  In order to manage the system
  I would like to be able to find invoices

  Background:
    Given the following admins exist
      | email           | password  | password_confirmation |
      | admin@yahoo.com | 12345678  | 12345678              |
    Given the following categories exist
      | name        | id |
      | Målare      | 1  |
    Given the following cities exist
      | name      | id |
      | Göteborg  | 1  |
    Given the following shifts exist
      | start_date  | start_time | end_date   | end_time | id |
      | 2019-01-01  | 18:00      | 2019-01-01 | 20:00    | 20 |
    Given the following users exist
      | email           | first_name | last_name | password  | password_confirmation | id   |
      | felix@yahoo.com | felix      | ottander  | 12345678  | 12345678              | 9999 |
      | johan@yahoo.com | johan      | stjärtis  | 12345678  | 12345678              | 9998 |
    Given the following profiles exist
      | username | description | category_ids | city_ids | user_id | id   | age        |
      | Fisken   | målare gbg  | 1            | 1        | 9999    | 9999 | 1988-09-14 |
      | Greger   | målare gbg  | 1            | 1        | 9998    | 9998 | 1988-09-14 |
    Given the following companies exist
      | email          | name | username | address | zip_code | city | org_number | phone | password  | password_confirmation | id   |
      | felix@mail.com | bill | anders p | gatan 3 | 53653643 | gbgb | 3453324533 | 98789 | 12345678  | 12345678              | 9999 |
      | johan@mail.com | brag | johans p | gatan 3 | 53653643 | gbgb | 3453324533 | 98789 | 12345678  | 12345678              | 9998 |
    Given the following invoices exist
      | description | amount | user_reference | terms | id    | company_id | paid  | user_id    | shift_ids |
      | abc         | 120    | felix          | 10    | 9999  | 9999       | false | 9999       | 20        |
      | def         | 120    | felix          | 10    | 9998  | 9998       | false | 9998       | 20        |
      | ghi         | 120    | felix          | 10    | 9997  | 9998       | true  | 9998       | 20        |

    Scenario: I see invoices and search by id
      Given I am logged in as admin "admin@yahoo.com"
      Given I am on the administrations page
      And I should see "User ID: 9998"
      And I click "Fakturor"
      And I click "Filtrera ej betalda"
      And I should see "abc"
      And I should see "def"
      And I should not see "ghi"
      And I click "Fakturor"
      And I click "Filtrera betalda"
      And I should see "ghi"
      And I should not see "abc"
      And I should not see "def"

    Scenario: I see invoices and search by user id
      Given I am logged in as admin "admin@yahoo.com"
      Given I am on the administrations page
      And I should see "User ID: 9998"
      And I click "Fakturor"
      And I should see "Alla fakturor"
      And I fill in "with_user_id" with "9998"
      And I click "Sök"
      Then I should not see "abc"
      And I should see "def"
      Given I am on the administrations page
      And I click "Fakturor"
      And I should see "Alla fakturor"
      And I fill in "with_company_id" with "9998"
      And I click "Sök"
      Then I should not see "abc"
      And I should see "def"

    Scenario: I see invoices and mark it as paid
      Given I am logged in as admin "admin@yahoo.com"
      Given I am on the administrations page
      And I should see "User ID: 9998"
      And I click "Fakturor"
      And I click link "Visa/godkänn faktura" in "abc"
      And I click "Markera som betald"
      And I should see "Faktura betald"
      Given I am on the administrations page
      And I click "Fakturor"
      And I click link "Visa/godkänn faktura" in "abc"
      Then I should see "Fakturan har blivit betald"

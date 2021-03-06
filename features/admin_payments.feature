Feature: Admin payments
  As a system owner
  In order to manage the system
  I would like to be able to find invoices that should be paid and mark them as paid

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
      | start_date  | start_time | end_date   | end_time | id | invoice_id |
      | 2019-01-01  | 18:00      | 2019-01-01 | 20:00    | 20 | 9999       |
      | 2019-01-01  | 18:00      | 2019-01-01 | 20:00    | 21 | 9998       |
      | 2019-01-01  | 18:00      | 2019-01-01 | 20:00    | 22 | 9997       |
      | 2019-01-01  | 18:00      | 2019-01-01 | 20:00    | 23 | 9996       |
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
      | description | amount | user_reference | terms | id    | company_id | created_at | paid  | user_id    | salary_paid | job_id | job_title | shift_ids |
      | abc         | 120    | felix          | 10    | 9999  | 9999       | 2017-11-01 | false | 9999       | false       | 1      | heyheyhey | 20        |
      | def         | 120    | felix          | 10    | 9998  | 9998       | 2017-11-02 | false | 9998       | false       | 2      | heyhethey | 21        |
      | ghi         | 120    | felix          | 10    | 9997  | 9998       | 2017-11-03 | true  | 9998       | false       | 3      | heyheihey | 22        |
      | jkl         | 120    | felix          | 10    | 9996  | 9998       | 2017-11-01 | true  | 9998       | true        | 4      | heyheuhey | 23        |

    Scenario: I see invoices and which has been payed and when to pay
      Given I am logged in as admin "admin@yahoo.com"
      Given I am on the administrations page
      And I click "Betalningar"
      And I should see "Fakturor som inte betalats ut"
      And I should see "abc"
      And I should see "def"
      And I should see "ghi"
      And I should not see "jkl"
      And I fill in "with_user_id" with "9999"
      And I click "Sök"
      And I should see "abc"
      And I should not see "def"
      And I click link "Visa/godkänn faktura" in "abc"
      And I click "Markera som lön utbetald"
      And I should see "Lön har blivit utbetald"
      Given I am on the administrations page
      And I click "Betalningar"
      Then I should see "def"
      And I should not see "abc"
      And I click "Visa utbetalda"
      And I should see "abc"
      And I fill in "with_user_id" with "9999"
      And I click "Sök"
      And I should see "abc"
      And I click "Logga ut"
      Given I am logged in as user "felix@yahoo.com"
      Given I am on the dashboards page
      Then I should see "Admin gjorde en utbetalning till dig"

    Scenario: I filter to the invoices where salary has been paid
      Given I am logged in as admin "admin@yahoo.com"
      Given I am on the administrations page
      And I click "Betalningar"
      And I click "Visa utbetalda"
      And I should see "jkl"
      And I should not see "abc"

Feature: Payments
  As an user
  In order to manage my payments
  I would like to be able to find payments in my dashboard

  Background:
    Given the following categories exist
      | name        | id |
      | Målare      | 1  |
    Given the following cities exist
      | name      | id |
      | Göteborg  | 1  |
    Given the following users exist
      | email           | password  | password_confirmation | id   |
      | felix@yahoo.com | 12345678  | 12345678              | 9999 |
    Given the following profiles exist
      | username | title        | description | category_ids | city_ids | user_id | id   |
      | Fisken   | målare 29 år | målare gbg  | 1            | 1        | 9999    | 9999 |
    Given the following companies exist
      | email          | name | username | address | zip_code | city | org_number | phone | password  | password_confirmation | id   |
      | felix@mail.com | bill | anders p | gatan 3 | 53653643 | gbgb | 3453324533 | 98789 | 12345678  | 12345678              | 9999 |
    Given the following invoices exist
      | description | amount  | user_reference | terms | active | id    | company_id | updated_at | paid  | user_id    | profile_id | salary_paid |
      | abc         | 3000    | felix          | 30    | true   | 9999  | 9999       | 2017-11-01 | false | 9999       | 9999       | true        |
      | def         | 3000    | felix          | 30    | true   | 9998  | 9999       | 2017-11-02 | false | 9999       | 9999       | false       |
    Given the following ezinvoices exist
      | org_number | company_name | company_address | company_zip | company_city | company_email | description | amount | user_reference | terms | active | id | updated_at | paid  | user_id | profile_id | salary_paid |
      | 1234       | greger ab    | södra 1         | 412         | gbg          | a@mail.com    | ezabc       | 3000   | felix          | 30    | true   | 44 | 2017-12-01 | false | 9999    | 9999       | true        |
      | 1235       | greger bb    | södra 2         | 413         | gbg          | b@mail.com    | ezdef       | 3000   | felix          | 30    | true   | 55 | 2017-12-01 | false | 9999    | 9999       | false       |

  Scenario: I see the payments
    Given I am logged in as user "felix@yahoo.com"
    Given I am on the dashboards page
    And I click "Utbetalningar"
    And I should see "Dina utbetalningar"
    And I should see "Faktura ID: 9999"
    And I should not see "Faktura ID: 9998"
    And I should see "Faktura ID: 44"
    And I should not see "Faktura ID: 55"
    And I click "2017-11-01 00:00"
    And I should see "Utbetalning"
    And I should see "Vår avgift: -179 SEK"
    And I should see "Sociala avgifter -674 SEK"
    And I should see "Bruttolön inkl sem. ers.	2146 SEK"
    And I should see "Skatt	-644 SEK"
    Then I should see "Nettolön (lön efter skatt) 1502 SEK"
    Given I am on the dashboards page
    And I click "Utbetalningar"
    And I click "2017-12-01 00:00"
    And I should see "Utbetalning"
    And I should see "Vår avgift: -179 SEK"
    And I should see "Sociala avgifter -674 SEK"
    And I should see "Bruttolön inkl sem. ers.	2146 SEK"
    And I should see "Skatt	-644 SEK"
    Then I should see "Nettolön (lön efter skatt) 1502 SEK"

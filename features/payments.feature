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
      | email          | first_name | last_name | password  | password_confirmation | id   |
      | felix@yahoo.com | felix      | ottander  | 12345678  | 12345678              | 9999 |
    Given the following profiles exist
      | username | title        | description | category_ids | city_ids | user_id | id   | age        |
      | Fisken   | målare 29 år | målare gbg  | 1            | 1        | 9999    | 9999 | 1988-09-14 |
    Given the following companies exist
      | email          | name | username | address | zip_code | city | org_number | phone | password  | password_confirmation | id   |
      | felix@mail.com | bill | anders p | gatan 3 | 53653643 | gbgb | 3453324533 | 98789 | 12345678  | 12345678              | 9999 |
    Given the following invoices exist
      | description | amount  | user_reference | terms | company_id | updated_at | paid  | user_id    | profile_id | salary_paid | user_fee | job_id | job_title |
      | abc         | 3000    | felix          | 15    | 9999       | 2017-11-01 | false | 9999       | 9999       | true        | 0.09     | 1      | heyhey    |
      | def         | 3000    | felix          | 15    | 9999       | 2017-11-02 | false | 9999       | 9999       | false       | 0.09     | 2      | hey hurhr |
    Given the following ezinvoices exist
      | org_number | company_name | company_address | company_zip | company_city | company_email | description | amount | user_reference | terms | updated_at | paid  | user_id | profile_id | salary_paid | user_fee |
      | 1234       | greger ab    | södra 1         | 412         | gbg          | a@mail.com    | ezabc       | 3000   | felix          | 15    | 2017-12-01 | false | 9999    | 9999       | true        | 0.09     |
      | 1235       | greger bb    | södra 2         | 413         | gbg          | b@mail.com    | ezdef       | 3000   | felix          | 15    | 2017-12-02 | false | 9999    | 9999       | false       | 0.09     |

  Scenario: I see the payments
    Given I am logged in as user "felix@yahoo.com"
    Given I am on the dashboards page
    And I click "Utbetalningar"
    And I should see "Utbetalningar"
    And I should see "Vi behöver personnummer och bankuppgifter"
    And I should not see "2017-11-01"
    And I click "klicka här"
    And I fill in "user_pers_num" with "8809144444"
    And I fill in "Nuvarande lösenord" with "12345678"
    And I click "Spara"
    Then I should see "Ditt konto har uppdaterats utan problem."
    And I click "Utbetalningar"
    And I should see "Vi behöver personnummer och bankuppgifter"
    And I click "klicka här"
    And I fill in "Kontonummer" with "2384753453"
    And I fill in "Nuvarande lösenord" with "12345678"
    And I click "Spara"
    Then I should see "Ditt konto har uppdaterats utan problem."
    And I click "Utbetalningar"
    And I should see "2017-11-01"
    And I should not see "Skapad: 2017-11-01"
    And I should see "Skapad: 2017-11-02"
    And I should see "2017-12-01"
    And I should not see "Skapad: 2017-12-01"
    And I should see "Skapad: 2017-12-02"
    And I click "2017-11-01 00:00"
    And I should see "Utbetalning"
    And I should see "Bruttolön: 3000"
    And I should see "Bruttolön inkl. semesterersättning(12%): 3360"
    And I should see "Din avgiftsnivå vid skapandet av fakturan: 9%"
    And I should see "Vår avgift: 302"
    And I should see "Ny bruttolön inkl sem. ers: 3058 SEK"
    And I should see "Skatt: -917 SEK"
    Then I should see "Nettolön(lön efter skatt): 2141 SEK"
    And I should see "Utbetald summa: 2141 SEK"
    Given I am on the dashboards page
    And I click "Utbetalningar"
    And I click "2017-12-01 00:00"
    And I should see "Utbetalning"
    And I should see "Bruttolön: 3000 "
    And I should see "Bruttolön inkl. semesterersättning(12%): 3360"
    And I should see "Din avgiftsnivå vid skapandet av fakturan: 9%"
    And I should see "Vår avgift: 302"
    And I should see "Ny bruttolön inkl sem. ers: 3058 SEK"
    And I should see "Skatt: -917 SEK"
    Then I should see "Nettolön (lön efter skatt): 2141 SEK"

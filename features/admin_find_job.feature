Feature: Admin find invoices
  As a system owner
  In order to manage the system
  I would like to be able to find invoices

  Background:
    Given the following categories exist
      | name        | id |
      | Målare      | 1  |
    Given the following admins exist
      | email           | password  | password_confirmation |
      | admin@yahoo.com | 12345678  | 12345678              |
    Given the following companies exist
      | email          | name | username | address | zip_code | city | org_number | phone | password  | password_confirmation | id   |
      | felix@mail.com | bill | anders p | gatan 3 | 53653643 | gbgb | 3453324533 | 98789 | 12345678  | 12345678              | 9999 |
      | johan@mail.com | brag | greger p | gatan 3 | 53653643 | gbgb | 3453324533 | 98789 | 12345678  | 12345678              | 9998 |
    Given the following job ads exist
      | title          | description | requirement      | category_ids | city | budget      | deadline   | duration | hour_week | active | company_username | company_city | company_id    | id   |
      | målare sökes   | måla hus    | 2 års erfarenhet | 1            | gbg  | 140kr/timma | 2018-10-10 | 14 dagar | 45        | true   | anders p         | Göteborg     | 9999          | 9999 |
      | snickare sökes | måla hus    | 2 års erfarenhet | 1            | gbg  | 140kr/timma | 2018-10-10 | 14 dagar | 45        | true   | greger p         | Göteborg     | 9998          | 9998 |
    Given the following users exist
      | email          | password  | password_confirmation | id |
      | felix@mail.com | 12345678  | 12345678              | 1  |
    Given the following profiles exist
      | username | title        | description | category_ids | city     | user_id | id |
      | Fisken   | 29 år målare | målare gbg  | 1            | Göteborg | 1       | 1  |
    Given the following applications exist
      | message    | job_id | profile_username | profile_id | job_title    |
      | I want job | 9999   | Fisken           | 1          | målare sökes |

    Scenario: I see jobs and search by title
      Given I am logged in as admin "admin@yahoo.com"
      Given I am on the administrations page
      And I click "Jobb"
      And I should see "Alla jobb"
      And I should see "målare sökes"
      And I should see "snickare sökes"
      And I fill in "with_id" with "9999"
      And I click "Sök"
      Then I should see "målare sökes"
      And I should not see "snickare sökes"

    Scenario: I see jobs and search by company username
      Given I am logged in as admin "admin@yahoo.com"
      Given I am on the administrations page
      And I click "Jobb"
      And I should see "Alla jobb"
      And I fill in "with_company_username" with "anders p"
      And I click "Sök"
      Then I should see "målare sökes"
      And I should not see "snickare sökes"
      Given I am on the administrations page
      And I click "Jobb"
      And I should see "Alla jobb"
      And I fill in "with_company_id" with "9999"
      And I click "Sök"
      Then I should see "målare sökes"
      And I should not see "snickare sökes"

    Scenario: I see jobs and click one to see applications
      Given I am logged in as admin "admin@yahoo.com"
      Given I am on the administrations page
      And I click "Jobb"
      And I should see "Alla jobb"
      And I click "målare sökes"
      Then I should see "I want job"

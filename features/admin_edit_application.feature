Feature: Admin find and edit application
  As a system owner
  In order to manage the system
  I would like to be able to edit applications

  Background:
    Given the following categories exist
      | name        | id |
      | Målare      | 1  |
    Given the following cities exist
      | name      | id |
      | Göteborg  | 1  |
    Given the following admins exist
      | email           | password  | password_confirmation |
      | admin@yahoo.com | 12345678  | 12345678              |
    Given the following companies exist
      | email          | name | username | address | zip_code | city | org_number | phone | password  | password_confirmation | id   |
      | felix@mail.com | bill | anders p | gatan 3 | 53653643 | gbgb | 3453324533 | 98789 | 12345678  | 12345678              | 9999 |
      | johan@mail.com | brag | greger p | gatan 3 | 53653643 | gbgb | 3453324533 | 98789 | 12345678  | 12345678              | 9998 |
    Given the following job ads exist
      | title          | description | requirement      | category_ids | city_ids | budget      | deadline   | duration | when_in_time | hour_day | active | company_username | company_city | company_id    | id   |
      | målare sökes   | måla hus    | 2 års erfarenhet | 1            | 1        | 140kr/timma | 2018-10-10 | 14 dagar | soon         | 8        | true   | anders p         | Göteborg     | 9999          | 9999 |
      | snickare sökes | måla hus    | 2 års erfarenhet | 1            | 1        | 140kr/timma | 2018-10-10 | 14 dagar | soon         | 8        | true   | greger p         | Göteborg     | 9998          | 9998 |
    Given the following users exist
      | email          | first_name | last_name | password  | password_confirmation | id |
      | felix@mail.com | felix      | ottander  | 12345678  | 12345678              | 1  |
    Given the following profiles exist
      | username | description | category_ids | city_ids | user_id | id | age        |
      | Fisken   | målare gbg  | 1            | 1        | 1       | 1  | 1988-09-14 |
    Given the following applications exist
      | message     | job_id | profile_username | profile_id | job_title    | updated_at | hired | complete | first_day | last_day | company_id |
      | I want job  | 9999   | Fisken           | 1          | målare sökes | 2017-12-03 | true  | false    |           |          | 9998       |

    Scenario: I find and edit application
      Given I am logged in as admin "admin@yahoo.com"
      Given I am on the administrations page
      And I click "Ansökningar"
      And I click "Redigera"
      And I fill in "* Första dag" with "2018-01-01"
      And I fill in "* Sista dag" with "2018-01-30"
      And I click "Spara"
      Then I should see "Ansökan ändrad"
      And I click "Logga ut"
      Given I am logged in as user "felix@mail.com"
      Given I am on the dashboards page
      Then I should see "Första jobbdag: 2018-01-01"
      Then I should see "Sista jobbdag: 2018-01-30"
      And I click "Logga ut"
      Given I am logged in as company "johan@mail.com"
      Given I am on control panel page
      Then I should see "Första jobbdag: 2018-01-01"
      Then I should see "Sista jobbdag: 2018-01-30"

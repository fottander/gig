Feature: Company control panel
  As a company user
  In order to structure my company info and jobs
  I would like to be able to have an account control panel

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
    Given the following companies exist
      | email          | name | username | address | zip_code | city     | org_number | phone | password  | password_confirmation | id |
      | felix@mail.com | bill | Anders p | gatan 3 | 53653643 | Göteborg | 3453324533 | 98789 | 12345678  | 12345678              | 1  |
    Given the following job ads exist
      | title          | description | requirement      | category_ids | city_ids | budget      | deadline   | duration | when_in_time | hour_day | active | company_username | company_city | company_id | id |
      | målare sökes   | måla hus    | 2 års erfarenhet | 1            | 1        | 140kr/timma | 2019-10-10 | 14 dagar | soon         | 8        | true   | Anders p         | Göteborg     | 1          | 1  |
      | snickare sökes | rita hus    | 2 års erfarenhet | 2            | 2        | 140kr/timma | 2017-10-10 | 14 dagar | soon         | 8        | true   | Anders p         | Göteborg     | 1          | 2  |
    Given the following users exist
      | email          | first_name | last_name | password  | password_confirmation | id |
      | felix@mail.com | felix      | ottander  | 12345678  | 12345678              | 1  |
    Given the following profiles exist
      | username | description | category_ids | city_ids | user_id | id | age        |
      | Fisken   | målare gbg  | 1            | 1        | 1       | 1  | 1988-09-14 |
    Given the following applications exist
      | message    | job_id | profile_username | profile_id | job_title    |
      | I want job | 1      | Fisken           | 1          | målare sökes |

    Scenario: I go to dashboard
      Given I am on the home page
      And I click "Logga in"
      And I click "som företag"
      And I should see "Logga in som företag"
      And I fill in "Email" with "felix@mail.com"
      And I fill in "Lösenord" with "12345678"
      And I click "Logga in" in actions
      Then I should see "Välkommen! Du är inloggad."
      And I should see "Skapa annons"

    Scenario: I see the job ad and applications answer count
      Given I am logged in as company "felix@mail.com"
      Given I am on control panel page
      And I should see "1" jobs description "målare sökes"
      And I should see "Antal ansökningar: 1"
      And I should not see "Sista ansökningsdag nådd" beside "1"
      Then I should see "Aktiv"
      And I should see "2" jobs description "snickare sökes"
      Then I should see "Sista ansökningsdag nådd" beside "2"
      And I click "Antal ansökningar: 1"
      Then I should see "Fisken"

    Scenario: I edit job jobtype and inactivate a job ad
      Given I am logged in as company "felix@mail.com"
      Given I am on the jobs page
      And I should see "målare sökes"
      And I click "Kontrollpanel"
      And I click job "1" button "Redigera"
      And I select "Deltid" from "job_jobtype"
      And I uncheck Active check box
      And I click "Spara"
      And I click "Kontrollpanel"
      Then I should see "Inaktivt"
      Given I am on the jobs page
      Then I should not see "målare sökes"

    Scenario: I go to job and see application replies
      Given I am logged in as company "felix@mail.com"
      Given I am on control panel page
      And I click "målare sökes"
      Then I should see "Fisken"

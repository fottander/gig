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
      | title        | description | requirement      | category_ids | city_ids | budget      | deadline   | duration | hour_week | active | company_username | company_city | company_id | id |
      | målare sökes | måla hus    | 2 års erfarenhet | 1            | 1        | 140kr/timma | 2018-10-10 | 14 dagar | 45        | true   | Anders p         | Göteborg     | 1          | 1  |
    Given the following users exist
      | email          | password  | password_confirmation | id |
      | felix@mail.com | 12345678  | 12345678              | 1  |
    Given the following profiles exist
      | username | title        | description | category_ids | city_ids | user_id | id |
      | Fisken   | 29 år målare | målare gbg  | 1            | 1        | 1       | 1  |
    Given the following applications exist
      | message    | job_id | profile_username | profile_id | job_title    |
      | I want job | 1      | Fisken           | 1          | målare sökes |

    Scenario: I go to dashboard
      Given I am on the home page
      And I click "LOGGA IN"
      And I click "Logga in företag >"
      And I should see "Logga in som företag"
      And I fill in "Email" with "felix@mail.com"
      And I fill in "Lösenord" with "12345678"
      And I click "Logga in"
      Then I should see "Välkommen! Du är inloggad."
      And I should see "Kontrollpanel"

    Scenario: I see the job ad and applications answer count
      Given I am logged in as company "felix@mail.com"
      Given I am on control panel page
      And I should see "målare sökes"
      And I should see "Antal ansökningar: 1"
      Then I should see "Aktiv"

    Scenario: I inactivate a job ad
      Given I am logged in as company "felix@mail.com"
      Given I am on the jobs page
      And I should see "målare sökes"
      And I click "KONTROLLPANEL"
      And I click "Redigera jobb"
      And I should see "Redigera annons"
      And I uncheck Active check box
      And I click "Spara"
      And I click "KONTROLLPANEL"
      Then I should see "Inaktivt"
      Given I am on the jobs page
      Then I should not see "målare sökes"

    Scenario: I go to job and see application replies
      Given I am logged in as company "felix@mail.com"
      Given I am on control panel page
      And I click "målare sökes"
      Then I should see "Fisken"

Feature: Company control panel
  As a company user
  In order to structure my company info and jobs
  I would like to be able to have an account control panel

  Background:
    Given the following companies exist
      | email          | name | username | address | zip_code | city     | org_number | phone | password  | password_confirmation | id |
      | felix@mail.com | bill | Anders p | gatan 3 | 53653643 | Göteborg | 3453324533 | 98789 | 12345678  | 12345678              | 1  |
    Given the following job ads exist
      | title        | description | requirement      | category | city | budget      | deadline   | duration | hour_week | active | company_username | company_city | company_id | id |
      | målare sökes | måla hus    | 2 års erfarenhet | målare   | gbg  | 140kr/timma | 2018-10-10 | 14 dagar | 45        | true   | Anders p         | Göteborg     | 1          | 1  |
    Given the following applications exist
      | message    | job_id |
      | I want job | 1      |

    Scenario: I go to dashboard
      Given I am on the home page
      And I click "LOGIN"
      And I click "Company login >"
      And I should see "Log in as company"
      And I fill in "Email" with "felix@mail.com"
      And I fill in "Password" with "12345678"
      And I click "Log in"
      Then I should see "Signed in successfully."
      And I should see "Company control panel"

    Scenario: I see the job ad and applications answer count
      Given I am logged in as company "felix@mail.com"
      Given I am on control panel page
      And I should see "målare sökes"
      And I should see "Antal svar: 1"
      Then I should see "Aktiv"

    Scenario: I inactivate a job ad
      Given I am logged in as company "felix@mail.com"
      Given I am on control panel page
      And I click "Edit job"
      And I should see "Edit job information"
      And I select "Målare" from "Categories"
      And I select "Göteborg" from "City"
      And I uncheck Active check box
      And I click "Submit"
      And I click "CONTROL PANEL"
      Then I should see "Inaktiv"

Feature: A company hires a person
  As a company
  In order to employ good people
  I would like to be able to hire a profile through an application

  Background:
    Given the following categories exist
      | name        | id |
      | Målare      | 1  |
      | Snickare    | 2  |
      | Plåtslagare | 3  |
    Given the following companies exist
      | email          | name | username | address | zip_code | city     | org_number | phone | password  | password_confirmation | id |
      | felix@mail.com | bill | Anders p | gatan 3 | 53653643 | Göteborg | 3453324533 | 98789 | 12345678  | 12345678              | 1  |
    Given the following job ads exist
      | title        | description | requirement      | category_ids | city | budget      | deadline   | duration | hour_week | active | company_username | company_city | company_id | id |
      | målare sökes | måla hus    | 2 års erfarenhet | 1            | gbg  | 140kr/timma | 2018-10-10 | 14 dagar | 45        | true   | Anders p         | Göteborg     | 1          | 1  |
    Given the following users exist
      | email          | password  | password_confirmation | id |
      | felix@mail.com | 12345678  | 12345678              | 1  |
    Given the following profiles exist
      | username | title        | description | category_ids | city     | user_id | id |
      | Fisken   | 29 år målare | målare gbg  | 1            | Göteborg | 1       | 1  |
    Given the following applications exist
      | message    | job_id | profile_username | profile_id | job_title    |
      | I want job | 1      | Fisken           | 1          | målare sökes |

    Scenario: I hire a profile
      Given I am logged in as company "felix@mail.com"
      Given I am on control panel page
      And I click "målare sökes"
      And I should see "Fisken"
      And I click "Visa"
      And I should see "I want job"
      And I click "Anställ"
      Then I should see "Grattis! Du har anlitat personen."
      And I click "KONTROLLPANEL"
      Then I should see "Fisken"

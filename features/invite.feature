Feature: Invite feature
  As a company
  In order to get more quotes
  I would like to be able to invite freelancers to jobs

  Background:
    Given the following categories exist
      | name        | id |
      | Målare      | 1  |
    Given the following companies exist
      | email          | name | username | address | zip_code | city     | org_number | phone | password  | password_confirmation | id |
      | felix@mail.com | bill | Anders p | gatan 3 | 53653643 | Göteborg | 3453324533 | 98789 | 12345678  | 12345678              | 1  |
    Given the following users exist
      | email          | password  | password_confirmation | id |
      | felix@mail.com | 12345678  | 12345678              | 1  |
    Given the following job ads exist
      | title        | description | requirement      | category_ids | city | budget      | deadline   | duration | hour_week | active | company_username | company_city | company_id | id |
      | målare sökes | måla hus    | 2 års erfarenhet | 1            | gbg  | 140kr/timma | 2018-10-10 | 14 dagar | 45        | true   | Anders p         | Göteborg     | 1          | 1  |
      | plåtis sökes | måla hus    | 2 års erfarenhet | 1            | gbg  | 140kr/timma | 2017-10-10 | 14 dagar | 45        | true   | Anders p         | Göteborg     | 1          | 2  |
    Given the following profiles exist
      | username | title        | description | category_ids | city     | user_id |
      | Fisken   | målare 29 år | målare gbg  | 1            | Göteborg | 1       |

    Scenario: I invite an user
      Given I am logged in as company "felix@mail.com"
      Given I am on the home page
      And I click "HITTA FRILANSARE"
      And I click "Fisken"
      And I click "Bjud in till jobb"
      And I fill in "message" with "Hello"
      And I select "målare sökes" from "job_id"
      And I click "Skicka inbjudan"
      Then I should see "Ny inbjudan skickad!"

    Scenario: I invite an user without selecting job
      Given I am logged in as company "felix@mail.com"
      Given I am on the home page
      And I click "HITTA FRILANSARE"
      And I click "Fisken"
      And I click "Bjud in till jobb"
      And I fill in "message" with "Hello"
      And I click "Skicka inbjudan"
      Then I should see "Fyll i alla fält korrekt!"

    Scenario: I invite an user without message
      Given I am logged in as company "felix@mail.com"
      Given I am on the home page
      And I click "HITTA FRILANSARE"
      And I click "Fisken"
      And I click "Bjud in till jobb"
      And I select "målare sökes" from "job_id"
      And I click "Skicka inbjudan"
      Then I should see "Fyll i alla fält korrekt!"

    Scenario: I try to invite to an expired job
      Given I am logged in as company "felix@mail.com"
      Given I am on the home page
      And I click "HITTA FRILANSARE"
      And I click "Fisken"
      And I click "Bjud in till jobb"
      And I should not see "plåtis sökes"
      Then I should see "målare sökes"

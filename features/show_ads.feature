Feature: Show job ads
  As an user
  In order to search for jobs
  I would like to browse all the job ads

  Background:
    Given the following categories exist
      | name   | id |
      | Målare | 1  |
    Given the following cities exist
      | name     | id |
      | Göteborg | 1  |
    Given the following companies exist
      | email          | name | username | address | zip_code | city | org_number | phone | password  | password_confirmation | id   |
      | felix@mail.com | bill | anders p | gatan 3 | 53653643 | gbgb | 3453324533 | 98789 | 12345678  | 12345678              | 9999 |
    Given the following job ads exist
      | title        | description | requirement      | category_ids | city_ids | budget      | deadline   | duration | when_in_time | hour_day | active | company_username | created_at | company_id |
      | målare       | måla hus    | 2 års erfarenhet | 1            | 1        | 140kr/timma | 2018-10-10 | 14 dagar | asap         | 8        | true   | Anders P         | 2018-01-01 | 9999       |
      | snickare     | måla hus    | 2 års erfarenhet | 1            | 1        | 140kr/timma | 2016-10-10 | 14 dagar | asap         | 8        | true   | Greger           | 2018-01-15 | 9999       |
      | plåtslagare  | måla hus    | 2 års erfarenhet | 1            | 1        | 140kr/timma | 2018-10-10 | 14 dagar | asap         | 8        | false  | Anders P         | 2018-01-31 | 9999       |

    Scenario: I see job ads
      Given I am on the home page
      And I click nav "HITTA JOBB"
      And I should see "Alla jobb"
      And I should see "målare"
      And I should see "måla hus"
      And I should see "målare"
      And I should see "Krav: 2 års erfarenhet"
      And I should see "Stad: Göteborg"
      And I should see "Jobbets längd: 14 dagar"
      And I should see "När: asap"
      And I should see "Timmar per dag: 8"
      And I should see "Anders P"
      And I should see "Skapad: 2018-01-01"
      And I should see "Går ut: 2018-10-10"
      Then I should see job "målare" avatar name "Default-company.png"
      And I click "Ansök"
      And I should see "målare"
      And I should see "måla hus"
      And I should see "målare"
      And I should see "Krav: 2 års erfarenhet"
      And I should see "Stad: Göteborg"
      And I should see "Jobbets längd: 14 dagar"
      And I should see "Timmar per dag: 8"
      And I should see "Anders P"
      And I should see "Sista ansökningsdag: 2018-10-10"
      And I should see "Föreslagen lön: 140kr/timma"
      And I should see "När ska jobbet utföras: asap"
      And I should see "Företagsinfo"
      And I should see "Anders P"
      And I should see "Antal genomförda jobb: 0"
      And I should see "Stad: gbgb"

    Scenario: I should not see ads where deadline is reached
      Given I am on the jobs page
      And I should see "målare"
      Then I should not see "snickare"

    Scenario: I should only see active ads
      Given I am on the jobs page
      And I should see "målare"
      Then I should not see "plåtslagare"

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
    Given the following job ads exist
      | title        | description | requirement      | category_ids | city_ids | budget      | deadline   | duration | hour_week | active | company_username | created_at |
      | målare       | måla hus    | 2 års erfarenhet | 1            | 1        | 140kr/timma | 2018-10-10 | 14 dagar | 45        | true   | Anders P         | 2018-01-01 |
      | snickare     | måla hus    | 2 års erfarenhet | 1            | 1        | 140kr/timma | 2016-10-10 | 14 dagar | 45        | true   | Greger           | 2018-01-15 |
      | plåtslagare  | måla hus    | 2 års erfarenhet | 1            | 1        | 140kr/timma | 2018-10-10 | 14 dagar | 45        | false  | Anders P         | 2018-01-31 |

    Scenario: I see job ads
      Given I am on the home page
      And I click nav "HITTA JOBB"
      And I should see "Alla jobb"
      And I should see "målare"
      And I should see "måla hus"
      And I should see "målare"
      And I should see "Krav: 2 års erfarenhet"
      And I should see "Stad: Göteborg"
      And I should see "Lön: 140kr/timma"
      And I should see "Varaktighet: 14 dagar"
      And I should see "Timmar/dag: 45"
      And I should see "Anders P"
      And I should see "Skapad: 2018-01-01"
      And I should see "Går ut: 2018-10-10"
      Then I should see job "målare" avatar name "Default-company.png"

    Scenario: I should not see ads where deadline is reached
      Given I am on the jobs page
      And I should see "målare"
      Then I should not see "snickare"

    Scenario: I should only see active ads
      Given I am on the jobs page
      And I should see "målare"
      Then I should not see "plåtslagare"

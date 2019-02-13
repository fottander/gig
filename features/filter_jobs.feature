Feature: Filter jobs
  As an user
  In order to filter through jobs
  I would like to browse all the job ads and filter by category, city and jobtype

  Background:
    Given the following categories exist
      | name     | id |
      | Målare   | 1  |
      | snickare | 2  |
      | plåt     | 3  |
      | städ     | 4  |
    Given the following cities exist
      | name     | id |
      | Göteborg | 1  |
      | Malmö    | 2  |
    Given the following companies exist
      | email          | name | username | address | zip_code | city | org_number | phone | password  | password_confirmation | id   |
      | felix@mail.com | bill | anders p | gatan 3 | 53653643 | gbgb | 3453324533 | 98789 | 12345678  | 12345678              | 9999 |
    Given the following job ads exist
      | title        | description | requirement      | category_ids | city_ids | jobtype               | budget      | deadline   | duration | when_in_time | hour_day | active | company_username | created_at | company_id |
      | målare       | måla hus    | 2 års erfarenhet | 1            | 1        | Visstid - Timanställd | 140kr/timma | 2019-10-10 | 14 dagar | asap         | 8        | true   | Anders P         | 2018-01-01 | 9999       |
      | snickare     | snickra hus | 2 års erfarenhet | 2            | 2        | Heltid - Timanställd  | 140kr/timma | 2016-10-10 | 14 dagar | asap         | 8        | true   | Greger           | 2018-01-15 | 9999       |
      | plåtslagare  | plåta hus   | 2 års erfarenhet | 3            | 1        | Projekt               | 140kr/timma | 2019-10-10 | 14 dagar | asap         | 8        | true   | Anders P         | 2018-01-31 | 9999       |
      | städare      | städa hus   | 2 års erfarenhet | 4            | 1        | Vikariat              | 140kr/timma | 2019-10-10 | 14 dagar | asap         | 8        | true   | Anders P         | 2018-01-31 | 9999       |
      | städare      | husstädning | 2 års erfarenhet | 4            | 1        | Vikariat              | 140kr/timma | 2019-10-10 | 14 dagar | asap         | 8        | true   | Anders P         | 2018-01-31 | 9999       |

      Scenario: I filter
        Given I am on the home page
        And I click nav "Hitta jobb"
        And I should see "Alla jobb"
        And I should see "målare"
        And I select "Målare" from "with_category"
        And I click "Filtrera"
        And I should see "måla hus"
        And I should not see "snickra hus"
        And I should not see "plåta hus"
        And I should not see "städa hus"
        And I click "x töm filter"
        And I select "Göteborg" from "with_city"
        And I click "Filtrera"
        And I should see "måla hus"
        And I should not see "snickra hus"
        And I should see "plåta hus"
        And I should see "städa hus"
        And I click "x töm filter"
        And I select "Visstid - Timanställd" from "with_jobtype"
        And I click "Filtrera"
        And I should see "måla hus"
        And I should not see "snickra hus"
        And I should not see "plåta hus"
        And I should not see "städa hus"
        And I click "x töm filter"
        And I select "Göteborg" from "with_city"
        And I select "Vikariat" from "with_jobtype"
        And I click "Filtrera"
        And I should see "städa hus"
        And I should see "husstädning"
        And I should not see "måla hus"
        And I should not see "snickra hus"

Feature: Show job ads
  As an user
  In order to search for jobs
  I would like to browse all the job ads

  Background:
    Given the following job ads exist
      | title        | description | requirement      | category | city | budget      | deadline   | duration | hour_week | active |
      | målare       | måla hus    | 2 års erfarenhet | målare   | gbg  | 140kr/timma | 2018-10-10 | 14 dagar | 45        | true   |
      | snickare     | måla hus    | 2 års erfarenhet | målare   | gbg  | 140kr/timma | 2016-10-10 | 14 dagar | 45        | true   |
      | plåtslagare  | måla hus    | 2 års erfarenhet | målare   | gbg  | 140kr/timma | 2018-10-10 | 14 dagar | 45        | false  |

    Scenario: I see job ads
      Given I am on the home page
      And I click "HITTA JOBB"
      And I should see "Browse all jobs"
      And I should see "målare"
      And I should see "måla hus"
      And I should see "målare"
      And I should see "gbg"
      And I should see "140kr/timma"
      And I should see "2018-10-10"
      And I should see "14 dagar"
      And I should see "45"

    Scenario: I should not see ads where deadline is reached
      Given I am on the jobs page
      And I should see "målare"
      Then I should not see "snickare"

    Scenario: I should only see active ads
      Given I am on the jobs page
      And I should see "målare"
      Then I should not see "plåtslagare"

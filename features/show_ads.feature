Feature: Show job ads
  As an user
  In order to search for jobs
  I would like to browse all the job ads

  Background:
    Given the following job ads exist
      | title   | description | category | city | budget      | deadline   | duration | hour_week |
      | målare  | måla hus    | målare   | gbg  | 140kr/timma | 2017-10-10 | 14 dagar | 45h/vecka |

    Scenario: I see job ads
      Given I am on the home page
      And I click "FIND A GIG"
      And I should see "Browse all gigs"
      And I should see "målare"
      And I should see "måla hus"
      And I should see "målare"
      And I should see "gbg"
      And I should see "140kr/timma"
      And I should see "2017-10-10"
      And I should see "14 dagar"
      And I should see "45h/vecka"

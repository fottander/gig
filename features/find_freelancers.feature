Feature: Show freelancers
  As a company
  In order to find good workers
  I would like to be able to search and find the avaialable freelancers

  Background:
    Given the following profiles exist
      | username | title | description | skill | rate | category | city |

    Scenario: I see freelancers
      Given I am on the home page
      And I click "FIND FREELANCERS"
      And I should see "Browse all freelancers"

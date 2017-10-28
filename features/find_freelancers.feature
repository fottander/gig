Feature: Show freelancers
  As a company
  In order to find good workers
  I would like to be able to filtrate and find the active freelancers

  Background:
    Given the following profiles exist
      | username | title               | description                                      | skill                      | rate              | category         | city     |
      | fisken   | Erfaren målare      | Erfaren målare och snickare med 5 års erfarenhet | måleri 5 år, snicker 3 år. | Från 150 kr/timma | Målare           | göteborg |
      | fisken   | Erfaren snickare    | Erfaren snickare med 5 års erfarenhet            | måleri 5 år, snicker 3 år. | Från 150 kr/timma | Snickare         | göteborg |
      | fisken   | Erfaren plåtslagare | Erfaren plåtslagare med 5 års erfarenhet         | måleri 5 år, snicker 3 år. | Från 150 kr/timma | Plåtslagare      | göteborg |

    Scenario: I see freelancers
      Given I am on the home page
      And I click "FIND FREELANCERS"
      And I should see "Browse all freelancers"
      And I should see "fisken"
      And I should see "Erfaren målare"
      And I should see "Erfaren målare och snickare med 5 års erfarenhet"
      And I should see "måleri 5 år, snicker 3 år."
      And I should see "Från 150 kr/timma"
      And I should see "Målare"
      Then I should see "göteborg"

    Scenario: I filtrate on a category
      Given I am on the home page
      And I click "FIND FREELANCERS"
      And I click "Snickare"
      Then I should see "Erfaren snickare"
      And I should not see "Erfaren målare"

Feature: Show freelancers
  As a company
  In order to find good workers
  I would like to be able to filtrate and find the active freelancers

  Background:
    Given the following users exist
      | email           | password  | password_confirmation | id |
      | felix@mail.com  | 12345678  | 12345678              | 1  |
      | anders@mail.com | 12345678  | 12345678              | 2  |
    Given the following profiles exist
      | username | title               | description                                      | skill                      | rate              | category         | city     | id | user_id |
      | fisken   | Erfaren målare      | Erfaren målare och snickare med 5 års erfarenhet | måleri 5 år, snicker 3 år. | Från 150 kr/timma | Målare           | göteborg | 1  | 1       |
      | anders   | Erfaren snickare    | Erfaren snickare med 5 års erfarenhet            | måleri 5 år, snicker 3 år. | Från 150 kr/timma | Snickare         | göteborg | 2  | 2       |
      | robert   | Erfaren plåtslagare | Erfaren plåtslagare med 5 års erfarenhet         | måleri 5 år, snicker 3 år. | Från 150 kr/timma | Plåtslagare      | göteborg | 3  |         |
    Given the following invoices exist
      | description | amount | user_reference | terms | active |id | user_id | profile_id | feedback   | job_id | updated_at  |
      | abc         | 120    | felix          | 30    | true   | 1 | 1       | 1          | Bra snubbe | 1      |  2017-11-11 |

    Scenario: I see freelancers
      Given I am on the home page
      And I click "HITTA FRILANSARE"
      And I should see "Alla frilansare"
      And I should see "fisken"
      And I should see "Erfaren målare"
      And I should see "Erfaren målare och snickare med 5 års erfarenhet"
      And I should see "måleri 5 år, snicker 3 år."
      And I should see "Från 150 kr/timma"
      And I should see "Målare"
      Then I should see "göteborg"
      And I click "fisken"
      Then I should see "Antal genomförda jobb: 1"
      And I should see "Jobbhistorik & feedback"
      And I should see "Bra snubbe"
      And I should see "2017 November"
      Then I should see "Jobb ID: 1"

    Scenario: I filtrate on a category
      Given I am on the home page
      And I click "HITTA FRILANSARE"
      And I click "Snickare"
      And I should see "Erfaren snickare"
      Then I should not see "Erfaren målare"

    Scenario: I see freelancers
      Given I am on the home page
      And I click "HITTA FRILANSARE"
      And I should see "Alla frilansare"
      And I should see "anders"
      And I should see "Erfaren snickare"
      And I should see "Erfaren snickare med 5 års erfarenhet"
      And I should see "måleri 5 år, snicker 3 år."
      And I should see "Från 150 kr/timma"
      And I should see "Snickare"
      Then I should see "göteborg"
      And I click "anders"
      Then I should not see "Antal genomförda jobb: 0"

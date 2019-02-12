Feature: Show freelancers
  As a company
  In order to find good workers
  I would like to be able to filtrate and find the active freelancers

  Background:
    Given the following users exist
      | email           | first_name | last_name | password  | password_confirmation | id |
      | felix@mail.com  | felix      | ottander  | 12345678  | 12345678              | 1  |
      | anders@mail.com | anders     | persson   | 12345678  | 12345678              | 2  |
      | robert@mail.com | robert     | robertson | 12345678  | 12345678              | 3  |
    Given the following categories exist
      | name        | id |
      | Målare      | 1  |
      | Snickare    | 2  |
      | Plåtslagare | 3  |
    Given the following cities exist
      | name      | id |
      | Göteborg  | 1  |
      | Stockholm | 2  |
      | Malmö     | 3  |
    Given the following shifts exist
      | start_date  | start_time | end_date   | end_time | id |
      | 2019-01-01  | 18:00      | 2019-01-01 | 20:00    | 20 |
    Given the following companies exist
      | email          | name | username | address | zip_code | city     | org_number | phone | password  | password_confirmation | id |
      | felix@mail.com | bill | Anders p | gatan 3 | 53653643 | Göteborg | 3453324533 | 98789 | 12345678  | 12345678              | 1  |
    Given the following profiles exist
      | username | description                                      | category_ids | city_ids | id | user_id | age        |
      | fisken   | Erfaren målare och snickare med 5 års erfarenhet | 1            | 1        | 1  | 1       | 1988-09-14 |
      | anders   | Erfaren snickare med 5 års erfarenhet            | 2            | 2        | 2  | 2       | 1988-09-14 |
      | robert   | Erfaren plåtslagare med 5 års erfarenhet         | 3            | 3        | 3  | 3       | 1988-09-14 |
    Given the following invoices exist
      | description | amount | user_reference | terms |id | user_id | profile_id | feedback   | job_id | job_title    | updated_at  | company_id | shift_ids |
      | abc         | 120    | felix          | 10    | 1 | 1       | 1          | Bra snubbe | 1      | Målare sökes | 2017-11-11  | 1          | 20        |

    Scenario: I see freelancers
      Given I am logged in as user "felix@mail.com"
      Given I am on the dashboards page
      And I click nav "Alla jobbsökare"
      And I should see "Alla Jobbsökare"
      And I should see "fisken"
      And I should see "Erfaren målare"
      And I should see "Erfaren målare och snickare med 5 års erfarenhet"
      And I should see "Målare"
      Then I should see "Stad: Göteborg"
      And I click "fisken"
      Then I should see "Antal genomförda jobb: 1"
      And I should see "30 år"
      And I should not see "Feedback"
      And I should not see "Bra snubbe"
      And I should not see "2017 November"
      Then I should not see "Målare sökes"

    Scenario: I filtrate on a city
      Given I am logged in as user "felix@mail.com"
      Given I am on the dashboards page
      And I click nav "Alla jobbsökare"
      And I select "Malmö" from "with_city"
      And I click "Filtrera"
      And I should see "Erfaren plåtslagare"
      Then I should not see "Erfaren målare"

    Scenario: I filtrate on a category
      Given I am logged in as user "felix@mail.com"
      Given I am on the dashboards page
      And I click nav "Alla jobbsökare"
      And I select "Plåtslagare" from "with_category"
      And I click "Filtrera"
      And I should see "Erfaren plåtslagare"
      Then I should not see "Erfaren snickare"

    Scenario: I see freelancers
      Given I am logged in as user "felix@mail.com"
      Given I am on the dashboards page
      And I click nav "Alla jobbsökare"
      And I should see "Alla Jobbsökare"
      And I should see "anders"
      And I should see "Erfaren snickare"
      And I should see "Erfaren snickare med 5 års erfarenhet"
      And I should see "Snickare"
      Then I should see "Göteborg"
      And I click "anders"
      And I should see "Antal genomförda jobb: 0"
      Then I should not see "Målare sökes"

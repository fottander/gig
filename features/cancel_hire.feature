Feature: Cancel hire
  As an user and company
  In order to get cancel an application
  The system should be able to have a cancel button when hired

Background:
  Given the following users exist
    | email           | password  | password_confirmation | id | first_name | last_name |
    | felix@mail.com  | 12345678  | 12345678              | 1  | felix      | ottander  |
  Given the following categories exist
    | name        | id |
    | Måleri      | 1  |
  Given the following cities exist
    | name      | id |
    | Göteborg  | 1  |
  Given the following companies exist
    | email          | name | username | address | zip_code | city     | org_number | phone | password  | password_confirmation | id |
    | felix@mail.com | bill | Anders p | gatan 3 | 53653643 | Göteborg | 3453324533 | 98789 | 12345678  | 12345678              | 1  |
  Given the following job ads exist
    | title        | description | requirement      | category_ids | city_ids | budget      | deadline   | duration | when_in_time | hour_day | active | company_username | company_city | company_id | id |
    | målare sökes | måla hus    | 2 års erfarenhet | 1            | 1        | 140kr/timma | 2018-10-10 | 14 dagar | soon         | 8        | true   | Anders p         | Göteborg     | 1          | 1  |
  Given the following profiles exist
    | username | description                                      | skill                      | category_ids | city_ids | id | user_id | age        |
    | fisken   | Erfaren målare och snickare med 5 års erfarenhet | måleri 5 år, snicker 3 år. | 1            | 1        | 1  | 1       | 1988-09-14 |
  Given the following applications exist
    | message    | job_id | profile_username | profile_id | job_title    | hired | complete | id | salary | add_ob | first_day  | last_day   |
    | I want job | 1      | fisken           | 1          | målare sökes | true  | false    | 1  | 700    | false  | 2019-01-01 | 2019-01-20 |

  Scenario: I create invioces and my fee lowers
    Given I am logged in as user "felix@mail.com"
    Given I am on the dashboards page
    And I click "Radera"
    And I click "Ta bort anställning"
    Then I should see "Anställningen raderad"
    And I should see "målare sökes" in not active applications
    Then I click "LOGGA UT"
    Given I am logged in as company "felix@mail.com"
    Given I am on control panel page
    And I should see "fisken lämnade återbud på din anställning"
    And I should see "målare sökes" in active jobs
    And I click "målare sökes"
    And I click "Visa ansökan"
    And I fill in "Startdag(t.ex. 2018-11-01)" with "2018-01-01"
    And I fill in "Sista dag(t.ex. 2018-12-30)" with "2018-01-20"
    And I fill in "Bruttolön(t.ex. 150)kr/timma" with "100"
    And I click "Anställ"
    Then I should see "Grattis! Du har anlitat personen"
    And I click "Avanställ/Ta bort"
    Then I should see "Anställningen raderad"
    And I click "LOGGA UT"
    Given I am logged in as user "felix@mail.com"
    Given I am on the dashboards page
    Then I should see "Anders p anställde dig för ansökan"
    And I should see "Anders p avanställde dig för anställningen"

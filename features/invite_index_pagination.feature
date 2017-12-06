Feature: Invite index pagination feature
  As a freelancer
  In order to see my invites
  I would like to be able to view my invites 5 per page

  Background:
    Given the following categories exist
      | name        | id |
      | Målare      | 1  |
    Given the following cities exist
      | name      | id |
      | Göteborg  | 1  |
      | Stockholm | 2  |
      | Malmö     | 3  |
    Given the following companies exist
      | email          | name | username | address | zip_code | city     | org_number | phone | password  | password_confirmation | id |
      | felix@mail.com | bill | Anders p | gatan 3 | 53653643 | Göteborg | 3453324533 | 98789 | 12345678  | 12345678              | 1  |
    Given the following users exist
      | email          | password  | password_confirmation | id |
      | felix@mail.com | 12345678  | 12345678              | 1  |
    Given the following job ads exist
      | title        | description | requirement      | category_ids | city_ids | budget      | deadline   | duration | hour_week | active | company_username | company_city | company_id | id |
      | målare sökes | måla hus    | 2 års erfarenhet | 1            | 1        | 140kr/timma | 2018-10-10 | 14 dagar | 45        | true   | Anders p         | Göteborg     | 1          | 1  |
      | plåtis sökes | måla hus    | 2 års erfarenhet | 1            | 1        | 140kr/timma | 2017-10-10 | 14 dagar | 45        | true   | Anders p         | Göteborg     | 1          | 2  |
    Given the following profiles exist
      | username | title        | description | category_ids | city_ids | user_id | id |
      | Fisken   | målare 29 år | målare gbg  | 1            | 1        | 1       | 1  |
    Given the following invites exist
      | message  | profile_id | company_id | job_id |
      | Invite 1 | 1          | 1          | 1      |
      | Invite 2 | 1          | 1          | 1      |
      | Invite 3 | 1          | 1          | 1      |
      | Invite 4 | 1          | 1          | 1      |
      | Invite 5 | 1          | 1          | 1      |
      | Invite 6 | 1          | 1          | 2      |

    Scenario: I see first 5 invites but not 6th
      Given I am logged in as user "felix@mail.com"
      Given I am on the dashboards page
      And I click "Inbjudningar"
      And I should see "Invite 6"
      And I should see "Invite 5"
      And I should see "Invite 4"
      And I should see "Invite 3"
      And I should see "Invite 2"
      And I should not see "Invite 1"
      And I click "Nästa"
      Then I should see "Invite 1"

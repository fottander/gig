Feature: Admin find profiles
  As a system owner
  In order to manage the system
  I would like to be able to find profiles

  Background:
    Given the following admins exist
      | email           | password  | password_confirmation |
      | admin@yahoo.com | 12345678  | 12345678              |
    Given the following users exist
      | email           | password  | password_confirmation | id   |
      | felix@yahoo.com | 12345678  | 12345678              | 9999 |
      | johan@yahoo.com | 12345678  | 12345678              | 9998 |
    Given the following categories exist
      | name        | id |
      | Målare      | 1  |
    Given the following cities exist
      | name      | id |
      | Göteborg  | 1  |
    Given the following profiles exist
      | username | title        | description | category_ids | city_ids | user_id | id   |
      | Fisken   | målare 29 år | målare gbg  | 1            | 1        | 9999    | 9999 |
      | Greger   | målare 29 år | målare gbg  | 1            | 1        | 9998    | 9998 |

    Scenario: I see profiles and search by username
      Given I am logged in as admin "admin@yahoo.com"
      Given I am on the administrations page
      And I click "Frilansare"
      And I should see "Alla frilansare"
      And I should see "Fisken"
      And I should see "Greger"
      And I fill in "with_username" with "Fisken"
      And I click "Sök"
      Then I should see "Fisken"
      And I should not see "Greger"
      And I click "Radera"
      And I should see "Frilansare raderad"
      Then I should not see "Fisken"

    Scenario: I see profiles and search by id
      Given I am logged in as admin "admin@yahoo.com"
      Given I am on the administrations page
      And I click "Frilansare"
      And I should see "Alla frilansare"
      And I fill in "with_id" with "9999"
      And I click "Sök"
      Then I should see "Fisken"
      And I should not see "Greger"

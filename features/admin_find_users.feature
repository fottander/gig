Feature: Admin find users
  As a system owner
  In order to manage the system
  I would like to be able to find users

  Background:
    Given the following admins exist
      | email           | password  | password_confirmation |
      | admin@yahoo.com | 12345678  | 12345678              |
    Given the following categories exist
      | name        | id |
      | Målare      | 1  |
    Given the following cities exist
      | name      | id |
      | Göteborg  | 1  |
    Given the following users exist
      | email           | password  | password_confirmation | id   |
      | felix@yahoo.com | 12345678  | 12345678              | 9999 |
      | johan@yahoo.com | 12345678  | 12345678              | 9998 |
    Given the following profiles exist
      | username | title        | description | category_ids | city_ids | user_id | id   |
      | Fisken   | målare 29 år | målare gbg  | 1            | 1        | 9999    | 9999 |

    Scenario: I see users and search by email
      Given I am logged in as admin "admin@yahoo.com"
      Given I am on the administrations page
      And I click "Användare"
      And I should see "Alla användare"
      And I should see "felix@yahoo.com"
      And I should see "johan@yahoo.com"
      And I fill in "with_email" with "felix@yahoo.com"
      And I click "Sök"
      Then I should see "felix@yahoo.com"
      And I should not see "johan@yahoo.com"
      And I click "Radera"
      And I should see "Användare raderad"
      Then I should not see "felix@yahoo.com"

    Scenario: I see users by id
      Given I am logged in as admin "admin@yahoo.com"
      Given I am on the administrations page
      And I click "Användare"
      And I should see "Alla användare"
      And I fill in "with_id" with "9999"
      And I click "Sök"
      Then I should see "felix@yahoo.com"
      And I should not see "johan@yahoo.com"
      And I click "Användare"
      And I click "Utan profil"
      Then I should see "johan@yahoo.com"
      And I should not see "felix@yahoo.com"

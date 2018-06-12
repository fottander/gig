Feature: Admin edit profiles
  As a system owner
  In order to manage the system
  I would like to be able to edit profiles

  Background:
    Given the following admins exist
      | email           | password  | password_confirmation |
      | admin@yahoo.com | 12345678  | 12345678              |
    Given the following users exist
      | email           | first_name | last_name | password  | password_confirmation | id   |
      | felix@yahoo.com | felix      | ottander  | 12345678  | 12345678              | 9999 |
      | johan@yahoo.com | johan      | stjärtis  | 12345678  | 12345678              | 9998 |
    Given the following categories exist
      | name        | id |
      | Målare      | 1  |
    Given the following cities exist
      | name      | id |
      | Göteborg  | 1  |
    Given the following profiles exist
      | username | title        | description | category_ids | city_ids | user_id | id   | age        |
      | Fisken   | målare 29 år | målare gbg  | 1            | 1        | 9999    | 9999 | 1988-09-14 |

    Scenario: I see profile and edit info
      Given I am logged in as admin "admin@yahoo.com"
      Given I am on the administrations page
      And I click "Frilansare"
      And I should see "Alla frilansare"
      And I click "Redigera"
      And I fill in "Födelsedatum" with "1988-10-14"
      And I click "Spara" in language
      Then I should see "Profil redigerad!"

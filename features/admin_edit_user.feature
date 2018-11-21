Feature: Admin find users and edit user info
  As a system owner
  In order to manage the system
  I would like to be able to find users and edit their info

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
      | email           | first_name | last_name | password  | password_confirmation | id   |
      | felix@yahoo.com | felix      | ottander  | 12345678  | 12345678              | 9999 |
    Given the following profiles exist
      | username | description | category_ids | city_ids | user_id | id   | age        |
      | Fisken   | målare gbg  | 1            | 1        | 9999    | 9999 | 1988-09-14 |

    Scenario: I see user and edit info
      Given I am logged in as admin "admin@yahoo.com"
      Given I am on the administrations page
      And I click "Användare"
      And I should see "Alla användare"
      And I click "Redigera"
      And I fill in "Telefonnummer" with "0707070700"
      And I fill in "Personnummer" with "8888888888"
      And I fill in "Bank" with "Nordea"
      And I fill in "Clearingnummer" with "3833"
      And I fill in "Kontonummer" with "12121212"
      And I click "Spara"
      Then I should see "User redigerad!"

Feature: Admin create city
  As a system owner
  In order to manage the system
  I would like to be able to create cities to chose from

  Background:
    Given the following admins exist
      | email           | password  | password_confirmation |
      | admin@yahoo.com | 12345678  | 12345678              |
    Given the following cities exist
      | name      |
      | Stockholm |

    Scenario: I edit city
      Given I am logged in as admin "admin@yahoo.com"
      Given I am on the administrations page
      And I click button "Edit" in city "Stockholm"
      And I should see "Edit stad"
      And I fill in "city_name" with "Göteborg"
      And I click "Spara"
      Then I should see "Stad redigerad!"
      And I should see "Göteborg"
      And I should not see "Stockholm"

    Scenario: I see cities and create one
      Given I am logged in as admin "admin@yahoo.com"
      Given I am on the administrations page
      And I should see "Stockholm"
      And I fill in "name" with "Göteborg" in city-name
      And I click "Skapa stad"
      Then I should see "Stad skapad"
      And I should see "Göteborg"

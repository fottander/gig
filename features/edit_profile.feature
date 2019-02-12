Feature: Edit profile
  As an user
  In order to have a good profile
  I would like to be able to edit my profile information

  Background:
    Given the following users exist
      | email          | first_name | last_name | password  | password_confirmation | id |
      | felix@mail.com | felix      | ottander  | 12345678  | 12345678              | 1  |
    Given the following categories exist
      | name        | id |
      | Målare      | 1  |
    Given the following cities exist
      | name      | id |
      | Göteborg  | 1  |

    Scenario: I edit profile
      Given I am logged in as user "felix@mail.com"
      Given I am on the dashboards page
      And I click "Skapa profil"
      And I should see "Skapa profil"
      And I fill in "Födelsedatum" with "1989-09-14"
      And I fill in "Beskrivning" with "Jag är en 29 årig målare och snickare från gbg"
      And I check Category check box
      And I select "Göteborg" from "Stad"
      And I click "Skapa"
      Then I should see "Ny profil skapad!"
      And I click "Redigera profil"
      And I should see "Redigera profil"
      And I fill in "Födelsedatum" with "1988-09-14"
      And I fill in "Beskrivning" with "målare från gbg"
      And I check Category check box
      And I select "Göteborg" from "Stad"
      And I click "Spara" in classic
      And I should see "Profil redigerad!"
      And I click "Kontrollpanel"
      And I click "Alla jobbsökare"
      Then I should see "målare från gbg"

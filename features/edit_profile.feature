Feature: Edit profile
  As an user
  In order to have a good profile
  I would like to be able to edit my profile information

  Background:
    Given the following users exist
      | email          | password  | password_confirmation |
      | felix@mail.com | 12345678  | 12345678              |
    Given the following categories exist
      | name        | id |
      | Målare      | 1  |

    Scenario: I edit profile
      Given I am logged in as user "felix@mail.com"
      Given I am on the dashboards page
      And I click "Skapa profil"
      And I should see "Skapa profil"
      And I fill in "Användarnamn" with "Fisken"
      And I fill in "Titel" with "Målare, snickare med lång erfarenhet"
      And I fill in "Beskrivning" with "Jag är en 29 årig målare och snickare från gbg"
      And I fill in "Färdigheter" with ""
      And I fill in "Lön" with ""
      And I check Category check box
      And I select "Göteborg" from "Stad"
      And I click "Skapa"
      Then I should see "Ny profil skapad!"
      And I click "Redigera profil"
      And I should see "Redigera profil"
      And I fill in "Användarnamn" with "fisken"
      And I fill in "Titel" with "målare"
      And I fill in "Beskrivning" with "målare från gbg"
      And I fill in "Färdigheter" with "målning och snickeri"
      And I check Category check box
      And I select "Göteborg" from "Stad"
      And I click "Spara"
      Then I should see "Profil redigerad!"

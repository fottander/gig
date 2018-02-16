Feature: User dashboard
  As an user
  In order to create a profile
  I would like to be able to have a profile dashboard

  Background:
    Given the following users exist
      | email          | password  | password_confirmation |
      | felix@mail.com | 12345678  | 12345678              |
    Given the following categories exist
      | name   | id |
      | Målare | 1  |
    Given the following cities exist
      | name      | id |
      | Göteborg  | 1  |

    Scenario: I go to dashboard
      Given I am on the home page
      And I click "LOGGA IN"
      And I should see "Logga in som frilansare"
      And I fill in "Email" with "felix@mail.com"
      And I fill in "Lösenord" with "12345678"
      And I click "Logga in"
      Then I should see "Välkommen! Du är inloggad."
      And I should see "Kontrollpanel"

    Scenario: I create a Profile
      Given I am logged in as user "felix@mail.com"
      Given I am on the dashboards page
      And I click "Skapa profil"
      And I should see "Skapa profil"
      And I fill in "Användarnamn" with "Fisken"
      And I fill in "Titel" with "Målare, snickare med lång erfarenhet"
      And I fill in "Beskrivning" with "Jag är en 29 årig målare och snickare från gbg"
      And I fill in "Färdigheter" with ""
      And I check Category check box
      And I select "Göteborg" from "Stad"
      And I attach file
      And I click "Skapa"
      Then I should see "Ny profil skapad!"
      And I click "HITTA FRILANSARE"
      And I should see "Fisken"
      Then I should see "Fisken" avatar name "Default-avatar.png"
      And I click "Fisken"
      Then I should see "Fisken" avatar name "Default-avatar.png"

Feature: User dashboard
  As an user
  In order to create a profile
  I would like to be able to have a profile dashboard

  Background:
    Given the following users exist
      | email          | password  | password_confirmation | id |
      | jonte@mail.com | 12345678  | 12345678              | 1  |
      | felix@mail.com | 12345678  | 12345678              | 2  |
    Given the following categories exist
      | name   | id |
      | Målare | 1  |
    Given the following cities exist
      | name      | id |
      | Göteborg  | 1  |
    Given the following profiles exist
      | username | title        | description | category_ids | city_ids | user_id | id |
      | Johan    | 29 år målare | målare gbg  | 1            | 1        | 1       | 1  |

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
      And I check Category check box
      And I select "Göteborg" from "Stad"
      And I click "Skapa"
      Then I should see "Ny profil skapad!"
      And I click "ALLA FRILANSARE"
      And I should see "Fisken"
      And I should see "Målare, snickare med lång erfarenhet"
      Then I should see "Jag är en 29 årig målare och snickare från gbg"

    Scenario: I create a Profile with already taken username
      Given I am logged in as user "felix@mail.com"
      Given I am on the dashboards page
      And I click "Skapa profil"
      And I should see "Skapa profil"
      And I fill in "Användarnamn" with "Johan"
      And I fill in "Titel" with "Målare, snickare med lång erfarenhet"
      And I fill in "Beskrivning" with "Jag är en 29 årig målare och snickare från gbg"
      And I check Category check box
      And I select "Göteborg" from "Stad"
      And I click "Skapa"
      Then I should see "Användarnamn används redan"

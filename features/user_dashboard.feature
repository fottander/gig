Feature: User dashboard
  As an user
  In order to create a profile
  I would like to be able to have a user dashboard

  Background:
    Given the following users exist
      | email          | first_name | last_name | password  | password_confirmation | id |
      | jonte@mail.com | jonte      | andersson | 12345678  | 12345678              | 1  |
      | felix@mail.com | felix      | ottander  | 12345678  | 12345678              | 2  |
    Given the following categories exist
      | name   | id |
      | Målare | 1  |
    Given the following cities exist
      | name      | id |
      | Göteborg  | 1  |
    Given the following profiles exist
      | username | description | category_ids | city_ids | user_id | id | age        |
      | Johan    | målare gbg  | 1            | 1        | 1       | 1  | 1988-09-14 |

    Scenario: I go to dashboard
      Given I am on the home page
      And I click "Logga in"
      And I click "som jobbsökare"
      And I should see "Logga in som jobbsökande"
      And I fill in "Email" with "felix@mail.com"
      And I fill in "Lösenord" with "12345678"
      And I click "Logga in" in actions
      Then I should see "Välkommen! Du är inloggad."
      And I should see "Innan du börjar söka jobb behöver du skapa en riktigt bra profil."

    Scenario: I create a Profile
      Given I am logged in as user "felix@mail.com"
      Given I am on the dashboards page
      Then I should see "Nästa steg är att skapa en profil"
      And I click "Skapa profil"
      And I should see "Skapa profil"
      And I fill in "Beskrivning" with "Jag är en 30 årig målare och snickare från gbg"
      And I check Category check box
      And I select "Göteborg" from "Stad"
      And I click "Skapa"
      And I should see "Ålder kan inte vara blankt!"
      And I fill in "Födelsedatum" with "1988-09-14"
      And I click "Skapa"
      Then I should see "Ny profil skapad!"
      And I click "Kontrollpanel"
      Then I should see "Nästa steg är att söka jobb"
      And I click "Alla jobbsökare"
      And I should see "Felix O"
      And I should see "30 år"
      Then I should see "Jag är en 30 årig målare och snickare från gbg"
      And I click "Kontrollpanel"
      And I click "Logga ut"
      And I click "Logga in"
      And I click "som jobbsökare"
      And I fill in "Email" with "felix@mail.com"
      And I fill in "Lösenord" with "12345678"
      And I click "Logga in" in actions
      And I should see "Förnamn: felix"
      Then I should not see "Nästa steg är att skapa en profil"

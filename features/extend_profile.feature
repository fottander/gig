Feature: Extend profile
  As an user
  In order to create a great profile
  I would like to be able to extend my profile

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
    Given the following profiles exist
      | username | title          | description                                      | category_ids | city_ids | id | user_id | age        |
      | fisken   | Erfaren målare | Erfaren målare och snickare med 5 års erfarenhet | 1            | 1        | 1  | 1       | 1988-09-14 |

    Scenario: I go to dashboard
      Given I am on the home page
      And I click "LOGGA IN"
      And I should see "Logga in som frilansare"
      And I fill in "Email" with "felix@mail.com"
      And I fill in "Lösenord" with "12345678"
      And I click "Logga in"
      Then I should see "Välkommen! Du är inloggad."
      And I should see "Förbättra dina chanser genom att lägga till utbildning!"
      And I should see "Förbättra dina chanser genom att lägga till arbetsplatser!"
      And I click "Profil"
      And I should see "Förbättra dina chanser genom att lägga till utbildning!"
      And I should see "Förbättra dina chanser genom att lägga till arbetsplatser!"
      And I fill in "Språk" with "Svenska och engelska"
      And I click "Spara" in language
      Then I should see "Profil redigerad!"
      And I fill in "Körkort" with "B-körkort"
      And I click "Spara" in license
      Then I should see "Profil redigerad!"
      And I fill in "Utbildning" with "Ekonomi"
      And I click "Spara" in education
      Then I should see "Profil redigerad!"
      And I should not see "Förbättra dina chanser genom att lägga till utbildning!"
      And I fill in "Tidigare arbetsplatser" with "Gbg husmåleri"
      And I click "Spara" in prev-work
      Then I should see "Profil redigerad!"
      And I should not see "Förbättra dina chanser genom att lägga till arbetsplatser!"
      And I fill in "Kompetenser" with "Måleri, snickeri"
      And I click "Spara" in skill
      Then I should see "Profil redigerad!"
      And I attach file
      And I click "Lägg till"
      And I should see "Profil redigerad!"
      And I click "ALLA FRILANSARE"
      Then I should see "fisken" avatar name "anewbiz-logo.png"
      And I click "fisken"
      Then I should see "fisken" avatar name "anewbiz-logo.png"
      And I should see "Svenska och engelska"
      And I should see "B-körkort"
      And I should see "Ekonomi"
      And I should see "Gbg husmåleri"
      And I should see "Måleri, snickeri"
      And I click "KONTROLLPANEL"
      And I should not see "Förbättra dina chanser genom att lägga till utbildning!"
      And I should not see "Förbättra dina chanser genom att lägga till arbetsplatser!"
      And I click "Profil"
      And I click "Visa din profil"
      And I should see "Svenska och engelska"
      Then I should see "fisken" avatar name "anewbiz-logo.png"

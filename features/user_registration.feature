Feature: User registration
  As an user
  In order to find work
  I would like to register an account

  Background:
    Given the following users exist
      | email          | first_name | last_name | password  | password_confirmation |
      | felix@mail.com | felix      | ottander  | 12345678  | 12345678              |
      Given the following categories exist
        | name   | id |
        | Målare | 1  |
      Given the following cities exist
        | name     | id |
        | Göteborg | 1  |
      Given the following companies exist
        | email          | name | username | address | zip_code | city | org_number | phone | password  | password_confirmation | id   |
        | felix@mail.com | bill | anders p | gatan 3 | 53653643 | gbgb | 3453324533 | 98789 | 12345678  | 12345678              | 9999 |
      Given the following job ads exist
        | title        | description | requirement      | category_ids | city_ids | budget      | deadline   | duration | when_in_time | hour_day | active | company_username | created_at | company_id |
        | målare       | måla hus    | 2 års erfarenhet | 1            | 1        | 140kr/timma | 2019-10-10 | 14 dagar | asap         | 8        | true   | Anders P         | 2018-01-01 | 9999       |
        | snickare     | måla hus    | 2 års erfarenhet | 1            | 1        | 140kr/timma | 2016-10-10 | 14 dagar | asap         | 8        | true   | Greger           | 2018-01-15 | 9999       |
        | plåtslagare  | måla hus    | 2 års erfarenhet | 1            | 1        | 140kr/timma | 2019-10-10 | 14 dagar | asap         | 8        | false  | Anders P         | 2018-01-31 | 9999       |

    Scenario: I register as a user
      Given I am on the home page
      And I click "Hitta Jobb"
      And I click "Ansök"
      And I click "Ansök"
      Then I should see "Du måste logga in eller registrera dig innan du fortsätter"
      And I should see "Registrera nytt konto som jobbsökande"
      And I fill in "Email" with "mail@mail.com"
      And I fill in "Förnamn" with "felix"
      And I fill in "Efternamn" with "ottander"
      And I fill in "Lösenord" with "12345678"
      And I fill in "Bekräfta lösenord" with "12345678"
      And I click "Registrera"
      Then I should see "Snart klar! Aktivera ditt konto genom att följa instruktionerna i det bekräftelse email vi skickat till mail@mail.com."
      And I fill in "Email" with "mail@mail.com"
      And I fill in "Lösenord" with "12345678"
      And I click "Logga in" in actions
      Then I should see "Du måste bekräfta din e-postadress innan du fortsätter."
      And I click nav "Logga in"
      And I click "som jobbsökare"
      And the last created user is marked confirmed
      And I fill in "Email" with "mail@mail.com"
      And I fill in "Lösenord" with "12345678"
      And I click "Logga in" in actions
      Then I should see "Välkommen! Du är inloggad"
      Then I should not see "Snart klar! Aktivera ditt konto genom att följa instruktionerna i det bekräftelse email vi skickat till mail@mail.com."
      And I should see "Innan du börjar söka jobb behöver du skapa en riktigt bra profil."
      And I click nav "Kontrollpanel"
      And I should see "Inga aktiva ansökningar"
      And I should see "Inga aktiva jobb"
      And I should see "Inga färdiga jobb"
      And I should see "Inga aktiva utbetalningar"
      Then I should see "Nästa steg är att skapa en profil"
      And I click "Logga ut"
      Given I am on the home page
      And I click nav "Logga in"
      And I click "som jobbsökare"
      And I should see "Logga in som jobbsökande"
      And I fill in "Email" with "mail@mail.com"
      And I fill in "Lösenord" with "12345678"
      And I click "Logga in" in actions
      Then I should see "Välkommen! Du är inloggad."
      And I should not see "Välkommen till Qnekt"
      And I should not see "Nästa steg är att söka jobb"
      Then I should see "Nästa steg är att skapa en profil"

    Scenario: I register as a user with double names
      Given I am on the home page
      And I click "Hitta Jobb"
      And I click "Ansök"
      And I click "Ansök"
      And I should see "Registrera nytt konto som jobbsökande"
      And I fill in "Email" with "mail@mail.com"
      And I fill in "Förnamn" with "Anna Lena"
      And I fill in "Efternamn" with "ottander"
      And I fill in "Lösenord" with "12345678"
      And I fill in "Bekräfta lösenord" with "12345678"
      And I click "Registrera"
      Then I should see "Snart klar! Aktivera ditt konto genom att följa instruktionerna i det bekräftelse email vi skickat till mail@mail.com."
      And I click nav "Logga in"
      And I click "som jobbsökare"
      And the last created user is marked confirmed
      And I fill in "Email" with "mail@mail.com"
      And I fill in "Lösenord" with "12345678"
      And I click "Logga in" in actions
      And I should see "Skapa profil"
      And I fill in "Beskrivning" with "Jag är en 30 årig målare och snickare från gbg"
      And I check Category check box
      And I fill in "Födelsedatum" with "1988-09-14"
      And I select "Göteborg" from "Stad"
      And I click "Skapa"
      Then I should see "Ny profil skapad!"
      And I click "Alla jobbsökare"
      Then I should see "Anna lena O"

    Scenario: I register without first name or last name
      Given I am on the home page
      And I click "Hitta Jobb"
      And I click "Ansök"
      And I click "Ansök"
      And I should see "Registrera nytt konto som jobbsökande"
      And I fill in "Email" with "greger@mail.com"
      And I fill in "Lösenord" with "12345678"
      And I fill in "Bekräfta lösenord" with "12345678"
      And I click "Registrera"
      And I should see "Förnamn är inte ifyllt"
      Then I should see "Efternamn är inte ifyllt"

    Scenario: I login as a user
      Given I am on the home page
      And I click "Logga in"
      And I click "som jobbsökare"
      And I should see "Logga in som jobbsökande"
      And I fill in "Email" with "felix@mail.com"
      And I fill in "Lösenord" with "12345678"
      And I click "Logga in" in actions
      Then I should see "Välkommen! Du är inloggad."

    Scenario: I register already taken user
      Given I am on the home page
      And I click "Hitta Jobb"
      And I click "Ansök"
      And I click "Ansök"
      And I should see "Registrera nytt konto som jobbsökande"
      And I fill in "Email" with "felix@mail.com"
      And I fill in "Lösenord" with "12345678"
      And I fill in "Bekräfta lösenord" with "12345678"
      And I click "Registrera"
      Then I should see "Email redan tagen"

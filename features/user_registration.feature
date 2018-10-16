Feature: User registration
  As an user
  In order to find work
  I would like to create an account

  Background:
    Given the following users exist
      | email          | first_name | last_name | password  | password_confirmation |
      | felix@mail.com | felix      | ottander  | 12345678  | 12345678              |

    Scenario: I register as a user
      Given I am on the home page
      And I click "REGISTRERA"
      And I should see "Registrera nytt konto som jobbsökande"
      And I fill in "Email" with "mail@mail.com"
      And I fill in "Förnamn" with "felix"
      And I fill in "Efternamn" with "ottander"
      And I fill in "Lösenord" with "12345678"
      And I fill in "Bekräfta lösenord" with "12345678"
      And I click "Registrera"
      Then I should see "Registrerad! Kolla din mail efter vår bekräftelse och följ instruktionerna"
      And the last created user is marked confirmed
      And I fill in "Email" with "mail@mail.com"
      And I fill in "Lösenord" with "12345678"
      And I click "Logga in"
      Then I should see "Välkommen! Du är inloggad"
      Then I should not see "Registrerad! Kolla din mail efter vår bekräftelse och följ instruktionerna"
      And I should see "Inga aktiva ansökningar"
      And I should see "Inga aktiva jobb"
      And I should see "Inga färdiga jobb"
      And I should see "Inga aktiva utbetalningar"
      Then I should see "Nästa steg är att skapa en profil"
      And I click "LOGGA UT"
      Given I am on the home page
      And I click "LOGGA IN"
      And I should see "Logga in som jobbsökande"
      And I fill in "Email" with "mail@mail.com"
      And I fill in "Lösenord" with "12345678"
      And I click "Logga in"
      Then I should see "Välkommen! Du är inloggad."
      And I should not see "Välkommen till A New Biz"
      Then I should not see "Nästa steg är att skapa en profil"

    Scenario: I register without first name or last name
      Given I am on the home page
      And I click "REGISTRERA"
      And I should see "Registrera nytt konto som jobbsökande"
      And I fill in "Email" with "greger@mail.com"
      And I fill in "Lösenord" with "12345678"
      And I fill in "Bekräfta lösenord" with "12345678"
      And I click "Registrera"
      And I should see "Förnamn är inte ifyllt"
      Then I should see "Efternamn är inte ifyllt"

    Scenario: I login as a user
      Given I am on the home page
      And I click "LOGGA IN"
      And I should see "Logga in som jobbsökande"
      And I fill in "Email" with "felix@mail.com"
      And I fill in "Lösenord" with "12345678"
      And I click "Logga in"
      Then I should see "Välkommen! Du är inloggad."

    Scenario: I register already taken user
      Given I am on the home page
      And I click "REGISTRERA"
      And I should see "Registrera nytt konto som jobbsökande"
      And I fill in "Email" with "felix@mail.com"
      And I fill in "Lösenord" with "12345678"
      And I fill in "Bekräfta lösenord" with "12345678"
      And I click "Registrera"
      Then I should see "Email redan tagen"

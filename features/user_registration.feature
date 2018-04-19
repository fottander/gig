Feature: User registration
  As an user
  In order to find work
  I would like to create an account

  Background:
    Given the following users exist
      | email          | password  | password_confirmation |
      | felix@mail.com | 12345678  | 12345678              |

    Scenario: I register as a user
      Given I am on the home page
      And I click "REGISTRERA"
      And I should see "Registrera ny frilansare"
      And I fill in "Email" with "mail@mail.com"
      And I fill in "Lösenord" with "12345678"
      And I fill in "Bekräfta lösenord" with "12345678"
      And I click "Registrera"
      Then I should see "Du är registrerad! Bekräfta att du fått"
      And I should see "Välkommen till A New Biz"
      And I click "DÖLJ"
      Then I should not see "Du är registrerad! Bekräfta att du fått"
      And I should see "Inga aktiva ansökningar"
      And I should see "Inga aktiva jobb"
      And I should see "Inga färdiga jobb"
      And I should see "Inga fakturor"
      Then I should see "Nästa steg är att skapa en profil"
      And I click "LOGGA UT"
      Given I am on the home page
      And I click "LOGGA IN"
      And I should see "Logga in som frilansare"
      And I fill in "Email" with "mail@mail.com"
      And I fill in "Lösenord" with "12345678"
      And I click "Logga in"
      Then I should see "Välkommen! Du är inloggad."
      And I should not see "Välkommen till A New Biz"
      Then I should not see "Nästa steg är att skapa en profil"

    Scenario: I login as a user
      Given I am on the home page
      And I click "LOGGA IN"
      And I should see "Logga in som frilansare"
      And I fill in "Email" with "felix@mail.com"
      And I fill in "Lösenord" with "12345678"
      And I click "Logga in"
      Then I should see "Välkommen! Du är inloggad."

    Scenario: I register already taken user
      Given I am on the home page
      And I click "REGISTRERA"
      And I should see "Registrera ny frilansare"
      And I fill in "Email" with "felix@mail.com"
      And I fill in "Lösenord" with "12345678"
      And I fill in "Bekräfta lösenord" with "12345678"
      And I click "Registrera"
      Then I should see "Email redan tagen"

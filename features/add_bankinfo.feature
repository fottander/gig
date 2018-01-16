Feature: Add bankinfo
  As a user
  In order to get paid
  I would like to be able to complete my account with bankinformation

  Background:
    Given the following users exist
      | email          | password  | password_confirmation | id |
      | felix@mail.com | 12345678  | 12345678              | 1  |

    Scenario: I add bankinformation
      Given I am logged in as user "felix@mail.com"
      Given I am on the dashboards page
      And I click "Konto"
      And I fill in "user_pers_num" with "8888883434"
      And I fill in "Bank" with "Nordea"
      And I fill in "Clearingnummer" with "1111"
      And I fill in "Kontonummer" with "123456"
      And I fill in "Nuvarande lösenord" with "12345678"
      And I click "Spara"
      Then I should see "Ditt konto har uppdaterats utan problem."

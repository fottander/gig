Feature: Add bankinfo
  As a user
  In order to get payed
  I would like to be able to complete my account with bankinformation

  Background:
    Given the following users exist
      | email          | password  | password_confirmation | id |
      | felix@mail.com | 12345678  | 12345678              | 1  |

    Scenario: I add bankinformation
      Given I am logged in as user "felix@mail.com"
      Given I am on the dashboard page
      And I click "Utbetalningar"
      And I should see "Betalningsinformation"
      And I click "Ange betalningsinformation"  

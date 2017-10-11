Feature: User dashboard
  As an user
  In order to create a profile
  I would like to be able to have a profile dashboard

  Background:
    Given the following users exist
      | email          | password  | password_confirmation |
      | felix@mail.com | 12345678  | 12345678              |

    Scenario: I go to dashboard
      Given I am on the home page
      And I click "LOGIN"
      And I should see "Log in as user"
      And I fill in "Email" with "felix@mail.com"
      And I fill in "Password" with "12345678"
      And I click "Log in"
      Then I should see "Signed in successfully."
      And I should see "Dashboard"

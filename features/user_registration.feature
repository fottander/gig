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
      And I click "REGISTER"
      And I should see "REGISTER AS USER"
      And I fill in "Email" with "mail@mail.com"
      And I fill in "Password" with "12345678"
      And I fill in "Password confirmation" with "12345678"
      And I click "Sign up"
      Then I should see "You have signed up successfully."

    Scenario: I login as a user
      Given I am on the home page
      And I click "LOGIN"
      And I should see "Log in as user"
      And I fill in "Email" with "felix@mail.com"
      And I fill in "Password" with "12345678"
      And I click "Log in"
      Then I should see "Signed in successfully."

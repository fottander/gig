Feature: Admin login
  As a system owner
  In order to manage the system
  I would like to be able to login to an admin section

  Background:
    Given the following admins exist
      | email           | password  | password_confirmation |
      | admin@yahoo.com | 12345678  | 12345678              |

    Scenario: I login as an admin
      Given I am on the admin login page
      And I should see "Logga in som admin"
      And I fill in "Email" with "admin@yahoo.com"
      And I fill in "Lösenord" with "12345678"
      And I click "Logga in" in actions
      Then I should see "Välkommen! Du är inloggad."
      And I click "Logga ut"
      Then I should see "Utloggad"

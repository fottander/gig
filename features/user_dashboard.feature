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

    Scenario: I create a Profile
      Given I am logged in as user "felix@mail.com"
      Given I am on the dashboards page
      And I click "Profile"
      And I should see "Create profile"
      And I fill in "Username" with "Fisken"
      And I fill in "Title" with "Målare, snickare med lång erfarenhet"
      And I fill in "Description" with "Jag är en 29 årig målare och snickare från gbg"
      And I fill in "Skills" with ""
      And I fill in "Rate" with ""
      And I fill in "Categories" with "målare, snickare, alltiallo"
      And I fill in "City" with "Göteborg"
      And I click "Submit"
      Then I should see "New profile created!"

Feature: Edit profile
  As an user
  In order to have a good profile
  I would like to be able to edit my profile information

  Background:
    Given the following users exist
      | email          | password  | password_confirmation |
      | felix@mail.com | 12345678  | 12345678              |

    Scenario: I edit profile
      Given I am logged in as user "felix@mail.com"
      Given I am on the dashboards page
      And I click "Create profile"
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
      And I click "Edit profile"
      And I should see "Edit profile information"
      And I fill in "Username" with "fisken"
      And I fill in "Title" with "målare"
      And I fill in "Description" with "målare från gbg"
      And I fill in "Skills" with "målning och snickeri"
      And I fill in "Categories" with "målare, snickare"
      And I fill in "City" with "gbg"
      And I click "Submit"
      Then I should see "Profile edited!"

Feature: Edit profile
  As an user
  In order to have a good profile
  I would like to be able to edit my profile information

  Background:
    Given the following users exist
      | email          | password  | password_confirmation |
      | felix@mail.com | 12345678  | 12345678              |

    Given the following profiles exist
      | username | title  | description         | category         | city     |
      | fisken   | målare | målare och snickare | målare, snickare | göteborg |

    Scenario: I edit profile
      Given I am logged in as user "felix@mail.com"
      Given I am on the dashboards page
      And I click "Edit profile"
      And I should see "Edit profile information"

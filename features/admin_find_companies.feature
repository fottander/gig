Feature: Admin find companies
  As a system owner
  In order to manage the system
  I would like to be able to find companies

  Background:
    Given the following admins exist
      | email           | password  | password_confirmation |
      | admin@yahoo.com | 12345678  | 12345678              |
    Given the following companies exist
    | email          | name | username | address | zip_code | city | org_number | phone | password  | password_confirmation | id   |
    | felix@mail.com | bill | anders p | gatan 3 | 53653643 | gbgb | 3453324533 | 98789 | 12345678  | 12345678              | 9999 |
    | johan@mail.com | brag | johans p | gatan 3 | 53653643 | gbgb | 3453324533 | 98789 | 12345678  | 12345678              | 9998 |

    Scenario: I see users and search by email
      Given I am logged in as admin "admin@yahoo.com"
      Given I am on the administrations page
      And I click "Företag"
      And I should see "Alla företag"
      And I should see "felix@mail.com"
      And I should see "johan@mail.com"
      And I fill in "with_email" with "felix@mail.com"
      And I click "Sök"
      Then I should see "felix@mail.com"
      And I should not see "johan@mail.com"
      And I click "Radera"
      And I should see "Företag raderat"
      Then I should not see "felix@mail.com"

    Scenario: I see users and search by name
      Given I am logged in as admin "admin@yahoo.com"
      Given I am on the administrations page
      And I click "Företag"
      And I should see "Alla företag"
      And I fill in "with_name" with "brag"
      And I click "Sök"
      Then I should not see "felix@mail.com"
      And I should see "johan@mail.com"

    Scenario: I see users and search by id
      Given I am logged in as admin "admin@yahoo.com"
      Given I am on the administrations page
      And I click "Företag"
      And I should see "Alla företag"
      And I fill in "with_id" with "9999"
      And I click "Sök"
      Then I should see "felix@mail.com"
      And I should not see "johan@mail.com"

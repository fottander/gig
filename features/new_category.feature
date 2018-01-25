Feature: Admin create category
  As a system owner
  In order to manage the system
  I would like to be able to create categories

  Background:
    Given the following admins exist
      | email           | password  | password_confirmation |
      | admin@yahoo.com | 12345678  | 12345678              |
    Given the following categories exist
      | name        |
      | Målare      |

    Scenario: I edit category
      Given I am logged in as admin "admin@yahoo.com"
      Given I am on the administrations page
      And I click button "Edit" in "Målare"
      And I should see "Edit kategori"
      And I fill in "category_name" with "Snickare"
      And I fill in "category_ssyk_code" with "1234"
      And I click "Spara"
      Then I should see "Kategori redigerad!"
      And I should see "Snickare"

    Scenario: I see categories and create one
      Given I am logged in as admin "admin@yahoo.com"
      Given I am on the administrations page
      And I should see "Målare"
      And I fill in "name" with "Städare"
      And I fill in "ssyk_code" with "1234"
      And I click "Skapa kategori"
      Then I should see "Kategori skapad"

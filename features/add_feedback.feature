Feature: Extend invoice and add feedback
  As a company user
  In order to help a freelancer get more jobs
  I would like to be able to give feedback

  Background:
    Given the following categories exist
      | name        | id |
      | Målare      | 1  |
    Given the following cities exist
      | name      | id |
      | Göteborg  | 1  |
    Given the following companies exist
      | email          | name | username | address | zip_code | city     | org_number | phone | password  | password_confirmation | id |
      | felix@mail.com | bill | Anders p | gatan 3 | 53653643 | Göteborg | 3453324533 | 98789 | 12345678  | 12345678              | 1  |
    Given the following users exist
      | email          | password  | password_confirmation | id   |
      | felix@mail.com | 12345678  | 12345678              | 9999 |
    Given the following profiles exist
      | username | title        | description | category_ids | city_ids | user_id | id   |
      | Fisken   | målare 29 år | målare gbg  | 1            | 1        | 9999    | 9999 |
    Given the following invoices exist
      | description | amount | user_reference | terms | active |id | company_id | user_id | profile_id | job_id | job_title    | paid  |
      | ref         | 120    | felix          | 15    | true   | 1 | 1          | 9999    | 9999       | 1      | Målare sökes | true  |
      | fer         | 120    | felix          | 15    | true   | 2 | 1          | 9999    | 9999       | 1      | Målare sökes | true  |
      | tyr         | 120    | felix          | 15    | true   | 3 | 1          | 9999    | 9999       | 1      | Målare sökes | true  |
      | abc         | 120    | felix          | 15    | false  | 4 | 1          | 9999    | 9999       | 1      | Målare sökes | false |

    Scenario: I give feedback with extended post and terms
      Given I am logged in as company "felix@mail.com"
      Given I am on control panel page
      And I click "Visa/Kontrollera"
      And I should see "abc"
      And I should see "Vill du rekommendera"
      And I fill in "feedback" with "Väldigt bra snubbe"
      And I check Terms check box
      And I check Post check box
      And I click "Spara"
      And I should see "Sparat!"
      And I click "ALLA FRILANSARE"
      And I click "Fisken"
      Then I should see "Väldigt bra snubbe"

    Scenario: I give feedback with extended post
      Given I am logged in as company "felix@mail.com"
      Given I am on control panel page
      And I click "Visa/Kontrollera"
      And I should see "abc"
      And I should see "Vill du rekommendera"
      And I fill in "feedback" with "Väldigt bra snubbe"
      And I check Post check box
      And I click "Spara"
      And I should see "Sparat!"
      And I click "ALLA FRILANSARE"
      And I click "Fisken"
      Then I should see "Väldigt bra snubbe"

    Scenario: I give feedback with extended terms
      Given I am logged in as company "felix@mail.com"
      Given I am on control panel page
      And I click "Visa/Kontrollera"
      And I should see "abc"
      And I should see "Vill du rekommendera"
      And I fill in "feedback" with "Väldigt bra snubbe"
      And I check Terms check box
      And I click "Spara"
      And I should see "Sparat!"
      And I click "ALLA FRILANSARE"
      And I click "Fisken"
      Then I should see "Väldigt bra snubbe"

    Scenario: I give feedback with no extended options
      Given I am logged in as company "felix@mail.com"
      Given I am on control panel page
      And I click "Visa/Kontrollera"
      And I should see "abc"
      And I should see "Vill du rekommendera"
      And I fill in "feedback" with "Väldigt bra snubbe"
      And I click "Spara"
      And I should see "Sparat!"
      And I click "ALLA FRILANSARE"
      And I click "Fisken"
      Then I should see "Väldigt bra snubbe"

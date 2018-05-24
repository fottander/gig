Feature: Extend invoice with post or email
  As a company user
  In order to receive my invoice in the proper way
  I would like to be able to extend it by setting email or postway

  Background:
    Given the following companies exist
      | email          | name | username | address | zip_code | city     | org_number | phone | password  | password_confirmation | id |
      | felix@mail.com | bill | Anders p | gatan 3 | 53653643 | Göteborg | 3453324533 | 98789 | 12345678  | 12345678              | 1  |
    Given the following users exist
      | email          | first_name | last_name | password  | password_confirmation | id |
      | felix@mail.com | felix      | ottander  | 12345678  | 12345678              | 1  |
    Given the following invoices exist
      | description | amount | user_reference | terms |id | company_id | user_id | job_id | job_title    | paid  |
      | ref         | 120    | felix          | 15    | 1 | 1          | 1       | 1      | Målare sökes | true  |
      | fer         | 120    | felix          | 15    | 2 | 1          | 1       | 1      | Målare sökes | true  |
      | try         | 120    | felix          | 15    | 3 | 1          | 1       | 1      | Målare sökes | true  |
      | abc         | 120    | felix          | 15    | 4 | 1          | 1       | 1      | Målare sökes | false |

    Scenario: I extend invoice with post
      Given I am logged in as company "felix@mail.com"
      Given I am on control panel page
      And I click "Visa/Kontrollera"
      And I should see "abc"
      Then I should see "Leveranssätt: Email"
      And I click "Lägg till" post button
      And invoice is sending by post
      And I should see "Leveranssätt: Post"
      Then I should not see "Klicka för att få fakturan på posten(+40kr)"

    Scenario: I extend invoice with 30 days terms
      Given I am logged in as company "felix@mail.com"
      Given I am on control panel page
      And I click "Visa/Kontrollera"
      And I should see "abc"
      And I should see invoice due date
      And I should not see "När du mottagit tre tidigare fakturor får du möjligheten att förlänga dina betalningsvillkor."
      And I click "Lägg till" terms button
      And I should see invoice new due date
      Then I should not see "Klicka för 30 dagars fakturatid(+500kr)"

    Scenario: I check the invoice extend terms clause i.e need 3 previous invoices
      Given I am logged in as company "felix@mail.com"
      Given I am on control panel page
      And the first invoice is being deleted
      And I click "Visa/Kontrollera"
      And I should see "abc"
      And I should see "Klicka för 30 dagars fakturatid(+500kr)"
      And I should see "När du mottagit tre tidigare fakturor får du möjligheten att förlänga dina betalningsvillkor."

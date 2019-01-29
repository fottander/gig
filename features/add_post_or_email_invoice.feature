Feature: Extend invoice with post or email
  As a company user
  In order to receive my invoice in the proper way
  I would like to be able to extend it by setting email or postway

  Background:
    Given the following shifts exist
      | start_date  | start_time | end_date   | end_time | id | invoice_id |
      | 2019-01-01  | 18:00      | 2019-01-01 | 20:00    | 20 | 1          |
      | 2019-01-01  | 18:00      | 2019-01-01 | 20:00    | 21 | 2          |
      | 2019-01-01  | 18:00      | 2019-01-01 | 20:00    | 22 | 3          |
    Given the following companies exist
      | email          | name | username | address | zip_code | city     | org_number | phone | password  | password_confirmation | id |
      | felix@mail.com | bill | Anders p | gatan 3 | 53653643 | Göteborg | 3453324533 | 98789 | 12345678  | 12345678              | 1  |
    Given the following users exist
      | email          | first_name | last_name | password  | password_confirmation | id |
      | felix@mail.com | felix      | ottander  | 12345678  | 12345678              | 1  |
    Given the following invoices exist
      | description | amount | user_reference | terms |id | company_id | user_id | job_id | job_title    | paid  | shift_ids |
      | fer         | 120    | felix          | 10    | 2 | 1          | 1       | 1      | Målare sökes | true  | 20        |
      | try         | 120    | felix          | 10    | 3 | 1          | 1       | 1      | Målare sökes | true  | 21        |
      | abc         | 120    | felix          | 10    | 4 | 1          | 1       | 1      | Målare sökes | false | 22        |

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

    Scenario: I extend invoice with 20 days terms
      Given I am logged in as company "felix@mail.com"
      Given I am on control panel page
      And I click "Visa/Kontrollera"
      And I should see "abc"
      And I should see invoice due date
      And I should not see "När du mottagit två tidigare fakturor får du möjligheten att förlänga dina betalningsvillkor."
      And I click "Lägg till" terms button
      And I should see invoice new due date
      Then I should not see "Klicka för 20 dagars fakturatid(+500kr)"

    Scenario: I check the invoice extend terms clause i.e need 2 previous invoices
      Given I am logged in as company "felix@mail.com"
      Given I am on control panel page
      And the first invoice is being deleted
      And I click "Visa/Kontrollera"
      And I should see "abc"
      And I should see "Klicka för 20 dagars fakturatid(+500kr)"
      And I should not see "Lägg till"
      And I should see "När du mottagit två tidigare fakturor får du möjligheten att förlänga dina betalningsvillkor."

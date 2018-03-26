Feature: Extend invoice with post or email
  As a company user
  In order to receive my invoice in the proper way
  I would like to be able to extend it by setting email or postway

  Background:
    Given the following companies exist
      | email          | name | username | address | zip_code | city     | org_number | phone | password  | password_confirmation | id |
      | felix@mail.com | bill | Anders p | gatan 3 | 53653643 | Göteborg | 3453324533 | 98789 | 12345678  | 12345678              | 1  |
    Given the following users exist
      | email          | password  | password_confirmation | id |
      | felix@mail.com | 12345678  | 12345678              | 1  |
    Given the following invoices exist
      | description | amount | user_reference | terms | active |id | company_id | user_id | job_id | job_title    | created_at | paid  |
      | ref         | 120    | felix          | 15    | true   | 1 | 1          | 1       | 1      | Målare sökes | 2017-12-01 | true  |
      | fer         | 120    | felix          | 15    | true   | 2 | 1          | 1       | 1      | Målare sökes | 2017-12-01 | true  |
      | try         | 120    | felix          | 15    | true   | 3 | 1          | 1       | 1      | Målare sökes | 2017-12-01 | true  |
      | abc         | 120    | felix          | 15    | false  | 4 | 1          | 1       | 1      | Målare sökes | 2018-01-01 | false |

    Scenario: I extend invoice with post
      Given I am logged in as company "felix@mail.com"
      Given I am on control panel page
      And I click "Visa/Kontrollera"
      And I should see "abc"
      And I check Post check box
      And I click "Spara"
      And I should see "Sparat!"
      And invoice is sending by post
      And I should see "Leveranssätt: Post"
      And I should see "Summa ex moms: 160 SEK"
      And I should see "Summa att betala: 200 SEK"
      Then I should not see "Klicka för att få fakturan på posten(+40kr)"

    Scenario: I extend invoice with email
      Given I am logged in as company "felix@mail.com"
      Given I am on control panel page
      And I click "Visa/Kontrollera"
      And I should see "abc"
      And I uncheck Post check box
      And I click "Spara"
      And I should see "Sparat!"
      Then I should see "Leveranssätt: Email"
      And I should see "Summa att betala: 150 SEK"

    Scenario: I extend invoice without specifying post or not
      Given I am logged in as company "felix@mail.com"
      Given I am on control panel page
      And I click "Visa/Kontrollera"
      And I should see "abc"
      And I click "Spara"
      And I should see "Sparat!"
      Then I should see "Leveranssätt: Email"
      And I should see "Summa att betala: 150"

    Scenario: I extend invoice with 30 days terms and post delivery
      Given I am logged in as company "felix@mail.com"
      Given I am on control panel page
      And I click "Visa/Kontrollera"
      And I should see "abc"
      And I should see "Fakturan ska betalas innan 2018-01-16"
      And I should not see "När du mottagit tre tidigare fakturor får du möjligheten att förlänga dina betalningsvillkor."
      And I check Terms check box
      And I check Post check box
      And I click "Spara"
      And I should see "Sparat!"
      And invoice is sending by post
      Then I should see "Leveranssätt: Post"
      And I should see "Summa ex moms: 660 SEK "
      And I should see "Summa att betala: 825 SEK"
      And I should see "Fakturan ska betalas innan 2018-01-31"
      And I should not see "Klicka för att få fakturan på posten(+40kr)"
      Then I should not see "Klicka för 30 dagars fakturatid(+500kr)"

    Scenario: I extend invoice with 30 days terms and post delivery
      Given I am logged in as company "felix@mail.com"
      Given I am on control panel page
      And the first invoice is being deleted
      And I click "Visa/Kontrollera"
      And I should see "abc"
      And I should see "Klicka för 30 dagars fakturatid(+500kr)"
      And I should see "När du mottagit tre tidigare fakturor får du möjligheten att förlänga dina betalningsvillkor."

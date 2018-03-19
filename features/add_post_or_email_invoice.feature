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
      | description | amount | user_reference | terms | active |id | company_id | user_id | job_id | job_title    | updated_at | paid  |
      | abc         | 120    | felix          | 30    | false  | 1 | 1          | 1       | 1      | Målare sökes | 2017-11-01 | false |

    Scenario: I extend invoice with post
      Given I am logged in as company "felix@mail.com"
      Given I am on control panel page
      And I click "Visa"
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
      And I click "Visa"
      And I should see "abc"
      And I uncheck Post check box
      And I click "Spara"
      And I should see "Sparat!"
      Then I should see "Leveranssätt: Email"
      And I should see "Summa att betala: 150 SEK"

    Scenario: I extend invoice without specifying post or not
      Given I am logged in as company "felix@mail.com"
      Given I am on control panel page
      And I click "Visa"
      And I should see "abc"
      And I click "Spara"
      And I should see "Sparat!"
      Then I should see "Leveranssätt: Email"
      And I should see "Summa att betala: 150"

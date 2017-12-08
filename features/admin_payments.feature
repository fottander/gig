Feature: Admin payments
  As a system owner
  In order to manage the system
  I would like to be able to find invoices that should be paid and mark them as paid

  Background:
    Given the following admins exist
      | email           | password  | password_confirmation |
      | admin@yahoo.com | 12345678  | 12345678              |
    Given the following users exist
      | email           | password  | password_confirmation | id   |
      | felix@yahoo.com | 12345678  | 12345678              | 9999 |
      | johan@yahoo.com | 12345678  | 12345678              | 9998 |
    Given the following companies exist
      | email          | name | username | address | zip_code | city | org_number | phone | password  | password_confirmation | id   |
      | felix@mail.com | bill | anders p | gatan 3 | 53653643 | gbgb | 3453324533 | 98789 | 12345678  | 12345678              | 9999 |
      | johan@mail.com | brag | johans p | gatan 3 | 53653643 | gbgb | 3453324533 | 98789 | 12345678  | 12345678              | 9998 |
    Given the following invoices exist
      | description | amount | user_reference | terms | active | id    | company_id | updated_at | paid  | user_id    | salary_paid |
      | abc         | 120    | felix          | 30    | true   | 9999  | 9999       | 2017-11-01 | false | 9999       | false       |
      | def         | 120    | felix          | 30    | true   | 9998  | 9998       | 2017-11-02 | false | 9998       | false       |
      | ghi         | 120    | felix          | 30    | true   | 9997  | 9998       | 2017-11-03 | true  | 9998       | false       |
      | jkl         | 120    | felix          | 30    | true   | 9996  | 9998       | 2017-11-01 | true  | 9998       | true        |

    Scenario: I see invoices and which has been payed and when to pay
      Given I am logged in as admin "admin@yahoo.com"
      Given I am on the administrations page
      And I click "Betalningar"
      And I should see "Alla aktiverade fakturor"
      And I should see "abc"
      And I should see "def"
      And I should see "ghi"
      And I should not see "jkl"
      And I fill in "pay_day" with "2017-11-01"
      And I click "Sök"
      And I should see "abc"
      And I should not see "def"
      And I click link "Visa/godkänn faktura" in "abc"
      And I click "Markera som lön utbetald"
      And I should see "Lön har blivit utbetald"
      Given I am on the administrations page
      And I click "Betalningar"
      Then I should see "def"
      And I should not see "abc"

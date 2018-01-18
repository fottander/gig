Feature: Admin find ezinvoices
  As a system owner
  In order to manage the system
  I would like to be able to find ezinvoices

  Background:
    Given the following admins exist
      | email           | password  | password_confirmation |
      | admin@yahoo.com | 12345678  | 12345678              |
    Given the following users exist
      | email           | password  | password_confirmation | id   |
      | felix@yahoo.com | 12345678  | 12345678              | 9999 |
      | johan@yahoo.com | 12345678  | 12345678              | 9998 |
    Given the following ezinvoices exist
      | org_number | company_name | company_address | company_zip | company_city | company_email | description | amount | user_reference | terms | active | updated_at | paid  | user_id    |
      | 1234       | greger ab    | södra 1         | 412         | gbg          | a@mail.com    | abc fakt    | 120    | felix          | 30    | true   | 2017-11-01 | false | 9999       |
      | 1235       | greger bb    | södra 2         | 413         | gbg          | b@mail.com    | def fakt    | 120    | felix          | 30    | false  | 2017-11-01 | false | 9998       |
      | 1233       | greger cc    | södra 3         | 414         | gbg          | c@mail.com    | ghi fakt    | 120    | felix          | 30    | true   | 2017-11-01 | true  | 9998       |

    Scenario: I see ezinvoices and search by id
      Given I am logged in as admin "admin@yahoo.com"
      Given I am on the administrations page
      And I click "Snabbfakturor"
      And I click "Filtrera ej betalda"
      And I should see "abc fakt"
      And I should not see "def fakt"
      And I should not see "ghi fakt"
      And I click "Snabbfakturor"
      And I click "Filtrera betalda"
      And I should see "ghi fakt"
      And I should not see "abc fakt"
      And I should not see "def fakt"

    Scenario: I see ezinvoices and search by user id
      Given I am logged in as admin "admin@yahoo.com"
      Given I am on the administrations page
      And I click "Snabbfakturor"
      And I should see "Alla snabbfakturor"
      And I fill in "with_user_id" with "9998"
      And I click "Sök"
      Then I should not see "abc fakt"
      And I should see "def fakt"

    Scenario: I see ezinvoices and mark it as paid
      Given I am logged in as admin "admin@yahoo.com"
      Given I am on the administrations page
      And I click "Snabbfakturor"
      And I click link "Visa/godkänn faktura" inside "def fakt"
      And I should see "Kan inte markeras som betald förrän fakturan är godkänd av kund"
      Given I am on the administrations page
      And I click "Snabbfakturor"
      And I click link "Visa/godkänn faktura" inside "abc fakt"
      And I click "Markera som betald"
      And I should see "Faktura betald"
      Given I am on the administrations page
      And I click "Snabbfakturor"
      And I click link "Visa/godkänn faktura" inside "abc fakt"
      Then I should see "Fakturan har blivit betald"
